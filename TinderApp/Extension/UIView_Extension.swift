//
//  UIView_Extension.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

extension UIView {
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        self.addConstraintFill()
    }
}

// MARK: - Add Loading View
extension UIView {
    func showLoadingView() {
        let blurLoader = LoadingView(frame: frame)
        self.addSubview(blurLoader)
    }

    func hideLoadingView() {
        if let blurLoader = subviews.first(where: { $0 is LoadingView }) {
            blurLoader.removeFromSuperview()
        }
    }
}
