//
//  UIApplication_Extension.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

public extension UIApplication {
    class func topViewController(baseViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigation = baseViewController as? UINavigationController {
            return topViewController(baseViewController: navigation.visibleViewController)
        }
        
        if let tabbar = baseViewController as? UITabBarController {
            if let selected = tabbar.selectedViewController {
                return topViewController(baseViewController: selected)
            }
        }
        
        if let presented = baseViewController?.presentedViewController {
            return topViewController(baseViewController: presented)
        }
        return baseViewController
    }
}
