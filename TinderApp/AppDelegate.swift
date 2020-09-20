//
//  AppDelegate.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tinderListViewController = TinderListViewController()
        let navigation = UINavigationController(rootViewController: tinderListViewController)
        guard let app: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return true
        }
        app.window?.rootViewController = navigation
        
        return true
    }
}

