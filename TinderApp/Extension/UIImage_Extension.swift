//
//  UIImage_Extension.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

extension UIImage {
    // get image from bundle
    static func bundleImage(named: String) -> UIImage {
        guard let image = UIImage(named: named, in: Bundle.main, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
}
