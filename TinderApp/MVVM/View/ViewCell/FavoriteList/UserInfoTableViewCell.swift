//
//  UserInfoTableViewCel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

class UserInfoTableViewCell: BaseTableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = ColorName.grayColor
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var fullNamelabel: UILabel = {
        let fullNamelabel = UILabel()
        fullNamelabel.textColor = ColorName.blackColor
        fullNamelabel.textAlignment = .left
        fullNamelabel.font = FontName.systemFont(ofSize: 17)
        fullNamelabel.translatesAutoresizingMaskIntoConstraints = false
        fullNamelabel.numberOfLines = 1
        fullNamelabel.text = "Full Name"
        return fullNamelabel
    }()
    
    private lazy var birthdayLabel: UILabel = {
        let birthdayLabel = UILabel()
        birthdayLabel.textColor = ColorName.blackColor
        birthdayLabel.textAlignment = .left
        birthdayLabel.font = FontName.systemFont(ofSize: 17)
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.numberOfLines = 1
        birthdayLabel.text = "Birthday"
        return birthdayLabel
    }()
    
    var userModel: UserModel? {
        didSet {
            guard let user = userModel else { return }
            fullNamelabel.text = user.name?.fullName
            birthdayLabel.text = user.birthday?.date
            let imageUrl = user.avatarImage?.largeImage ?? ""
            avatarImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setupSubviews() {
        backgroundColor = ColorName.whiteColor
        setupAvatarImage()
        setupFullNameLabel()
        setupBirthdayLabel()
    }

    func configure(data: UserModel) {
        userModel = data
    }
}

// MARK: - Private setup function
extension UserInfoTableViewCell {
    private func setupAvatarImage() {
        addSubview(avatarImageView)
        avatarImageView.addConstraint(fromLeft: 16)
        avatarImageView.addConstraint(fromTop: 16)
        avatarImageView.addConstraintWidth(60)
        avatarImageView.addConstraintHeight(60)
    }
    
    private func setupFullNameLabel() {
        addSubview(fullNamelabel)
        fullNamelabel.addConstraint(fromViewRight: avatarImageView, distance: 8)
        fullNamelabel.addConstraint(fromRight: 16)
        fullNamelabel.addConstraint(fromTop: 16)
        fullNamelabel.addConstraintHeight(25)
    }
    
    private func setupBirthdayLabel() {
        addSubview(birthdayLabel)
        birthdayLabel.addConstraint(fromViewRight: avatarImageView, distance: 8)
        birthdayLabel.addConstraint(fromRight: 16)
        birthdayLabel.addConstraint(fromViewBottom: fullNamelabel, distance: 8)
        birthdayLabel.addConstraint(fromBottom: 16)
    }
}
