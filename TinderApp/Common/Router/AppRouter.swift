//
//  AppRouter.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

public class AppRouter {
    static let shared = AppRouter()
    private init() {}
    
    public func gotoFavoriteList() {
        let favoriteListViewController = FavoriteListViewController()
        pushFromRoot(to: favoriteListViewController)
    }
}

// MARK: - Private function
extension AppRouter {
    private func pushFromRoot(to viewController: UIViewController) {
        if let rootViewController = UIApplication.topViewController() {
            rootViewController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


