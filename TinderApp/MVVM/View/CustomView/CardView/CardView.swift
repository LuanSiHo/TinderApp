//
//  CardView.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit
import SDWebImage

protocol CardViewDelegate: class {
    func didSwipeLeft(on view: CardView, at index: Int)
    func didSwipeRight(on view: CardView, at index: Int)
}

class CardView: BaseUIView {
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = ColorName.whiteColor
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowRadius = 2.0
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()

    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = ColorName.grayColor
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 75
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()

    private lazy var userInfoTitleLabel: UILabel = {
        let userInfoTitleLabel = UILabel()
        userInfoTitleLabel.textColor = ColorName.grayColor
        userInfoTitleLabel.textAlignment = .center
        userInfoTitleLabel.font = FontName.systemFont(ofSize: 14)
        userInfoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return userInfoTitleLabel
    }()
    
    private lazy var userInfoDetailLabel: UILabel = {
        let userInfoDetailLabel = UILabel()
        userInfoDetailLabel.textColor = ColorName.blackColor
        userInfoDetailLabel.textAlignment = .center
        userInfoDetailLabel.font = FontName.boldSystemFont(ofSize: 18)
        userInfoDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        userInfoDetailLabel.numberOfLines = 2
        return userInfoDetailLabel
    }()
    
    private lazy var bottomMenuView: MenuView = {
        let bottomMenuView = MenuView()
        bottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        bottomMenuView.delegate = self
        return bottomMenuView
    }()
    
    var userInfo: UserModel? {
        didSet {
            guard let userModel = userInfo else {return }
            updateUI(with: userModel, and: currentInfoType)
        }
    }
    
    var cardIndex: Int = 0
    
    private var currentInfoType: MenubarItemType = .name

    weak var delegate: CardViewDelegate?
    
    // MARK: Override function
    override func initComponents() {
        setupShadowView()
        setupContainerView()
        setupAvatarImageView()
        setupTitleLabel()
        setupDetailLabel()
        setupBottomMenuView()
        setupPanGesture()
    }
}

// MARK: - Private function
extension CardView {
    private func setupShadowView() {
        addSubview(shadowView)
        shadowView.fillSuperview()
    }
    
    private func setupContainerView() {
        shadowView.addSubview(containerView)
        containerView.fillSuperview()
    }
    
    private func setupAvatarImageView() {
        containerView.addSubview(avatarImageView)
        avatarImageView.addConstraintHeight(150)
        avatarImageView.addConstraintWidth(150)
        avatarImageView.addConstraintCenteringX()
        avatarImageView.addConstraintCenteringY(withOffset: -80)
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(userInfoTitleLabel)
        userInfoTitleLabel.addConstraintCenteringX()
        userInfoTitleLabel.addConstraint(fromViewBottom: avatarImageView, distance: 16)
    }
    
    private func setupDetailLabel() {
        containerView.addSubview(userInfoDetailLabel)
        userInfoDetailLabel.addConstraintCenteringX()
        userInfoDetailLabel.addConstraint(fromLeft: 4, toRight: 4)
        userInfoDetailLabel.addConstraint(fromViewBottom: userInfoTitleLabel, distance: 8)
    }
    
    private func setupBottomMenuView() {
        containerView.addSubview(bottomMenuView)
        bottomMenuView.addConstraint(fromLeft: 0, toRight: 0)
        bottomMenuView.addConstraint(fromBottom: 16)
        bottomMenuView.addConstraintHeight(50)
    }
    
    private func setupPanGesture() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
}

// MARK: - Handle Action
extension CardView {
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        guard let card = sender.view as? CardView else { return }
        let selectedPoint = sender.translation(in: self)
        let centerPointOfSuperView = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerPointOfSuperView.x + selectedPoint.x, y: centerPointOfSuperView.y + selectedPoint.y)
        
        switch sender.state {
        case .ended:
            if (card.center.x) > 300 {
                // swipe right
                delegate?.didSwipeRight(on: card, at: cardIndex)
                // perform animation and move card to the right of the screen
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerPointOfSuperView.x + selectedPoint.x + 200, y: centerPointOfSuperView.y + selectedPoint.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < -10 {
                // swipe left
                delegate?.didSwipeLeft(on: card, at: cardIndex)
                // perform animation and move card to the left of the screen
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerPointOfSuperView.x + selectedPoint.x - 200, y: centerPointOfSuperView.y + selectedPoint.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            
            // perform animation and move card to center of the screen
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            // rotate card when swiping
            let rotation = tan(selectedPoint.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
        default:
            break
        }
    }
}

// MARK: - MenuViewDelegate
extension CardView: MenuViewDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        guard let userModel = userInfo else { return }
        currentInfoType = MenubarItemType(rawValue: indexPath.item) ?? .name
        updateUI(with: userModel, and: currentInfoType)
    }
    
    private func updateUI(with userModel: UserModel, and type: MenubarItemType) {
        switch type {
        case .name:
            userInfoTitleLabel.text = DefineString.usernameMessage
            userInfoDetailLabel.text = userModel.name?.fullName
            break
        case .birthday:
            userInfoTitleLabel.text = DefineString.birthdayMessage
            userInfoDetailLabel.text = userModel.birthday?.date
            break
        case .address:
            userInfoTitleLabel.text = DefineString.addressMessage
            userInfoDetailLabel.text = userModel.location?.detailAddress
            break
        case .phone:
            userInfoTitleLabel.text = DefineString.phoneNumberMessage
            userInfoDetailLabel.text = userModel.phoneNumber
            break
        }
        
        let imageUrl = userModel.avatarImage?.largeImage ?? ""
        avatarImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
    }
}
