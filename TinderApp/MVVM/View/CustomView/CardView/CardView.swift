//
//  CardView.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

protocol CardViewDelegate: class {
    func didSwipeLeft(on view: CardView)
    func didSwipeRight(on view: CardView)
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
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 75
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderColor = ColorName.redColor.cgColor
        avatarImageView.layer.borderWidth = 2
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
        userInfoDetailLabel.text = "Hello World"
        return userInfoDetailLabel
    }()
    
    private lazy var bottomMenuView: MenuView = {
        let bottomMenuView = MenuView()
        bottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        bottomMenuView.delegate = self
        return bottomMenuView
    }()
    
    var dataSource: CardsDataModel? {
        didSet {
            userInfoTitleLabel.text = dataSource?.text
            guard let image = dataSource?.image else { return }
            avatarImageView.image = UIImage(named: image)
        }
    }

    weak var delegate : CardViewDelegate?
    
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
            if (card.center.x) > 400 {
                // swipe right
                delegate?.didSwipeRight(on: card)
                // perform animation and move card to the right of the screen
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerPointOfSuperView.x + selectedPoint.x + 200, y: centerPointOfSuperView.y + selectedPoint.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < -40 {
                // swipe left
                delegate?.didSwipeLeft(on: card)
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
        // todo:
    }
}
