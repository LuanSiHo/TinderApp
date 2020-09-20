//
//  MenuCollectionViewCell.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: BaseCollectionViewCell {
    
    static let cellId = "cellId"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = IconName.iconHome.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = ColorName.grayColor
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? ColorName.darkGreenColor : ColorName.grayColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? ColorName.darkGreenColor : ColorName.grayColor
        }
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(imageView)
        imageView.addConstraintHeight(28)
        imageView.addConstraintWidth(28)
        imageView.addConstraintCenteringXY()
    }
}

