//
//  BaseViewController.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    private lazy var viewModel: BaseViewModel = {
        return BaseViewModel(delegate: self)
    }()
}

// MARK: - Life Cycle
extension BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - override function
extension BaseViewController {
    @objc func setupView() {}
    @objc func setupNavigation() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK: - BaseViewModelDelegate
extension BaseViewController: BaseViewModelDelegate {
    
}

// MARK: - Navigation
extension BaseViewController {
    func setupNavigationTinderList() {
        customNavigationTinderList()
        addReloadLeftBarItem()
        addFavoriteRightBarItem()
        setNavigationTitle(DefineString.tinderListTitle)
    }
}

// MARK: - Custom Navigation
extension BaseViewController {
    func customNavigationTinderList() {
        let textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        navigationController?.navigationBar.barTintColor = ColorName.whiteColor

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    func setNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
    
    func setNavigationTitleView(_ titleView: UIView) {
        navigationItem.titleView = titleView
    }
}

// MARK: - UIBarButtonItem
extension BaseViewController {
    func addBackLeftBarItem() {
        let backButton = UIButton(type: .custom)
        backButton.backgroundColor = UIColor.clear
        backButton.addConstraintWidth(24, height: 44)
        backButton.setImage(IconName.iconCallPhone, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.addTarget(self, action: #selector(didTapBackLeftBarItem), for: .touchUpInside)

        let backView = UIView()
        backView.backgroundColor = UIColor.clear
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(backButton)
        backButton.fillSuperview()

        let backItem = UIBarButtonItem(customView: backView)
        navigationItem.leftBarButtonItem = backItem
    }
    
    func addReloadLeftBarItem() {
        let reloadButton = UIButton(type: .custom)
        reloadButton.backgroundColor = UIColor.clear
        reloadButton.addConstraintWidth(24, height: 44)
        reloadButton.setImage(IconName.iconCallPhone, for: .normal)
        reloadButton.tintColor = UIColor.white
        reloadButton.addTarget(self, action: #selector(didTapReloadBarItem), for: .touchUpInside)

        let reloadView = UIView()
        reloadView.backgroundColor = UIColor.clear
        reloadView.translatesAutoresizingMaskIntoConstraints = false
        reloadView.addSubview(reloadButton)
        reloadButton.fillSuperview()

        let reloadBarItem = UIBarButtonItem(customView: reloadView)
        navigationItem.leftBarButtonItem = reloadBarItem
    }
    
    func addFavoriteRightBarItem() {
        let favoriteButton = UIButton(type: .custom)
        favoriteButton.backgroundColor = UIColor.clear
        favoriteButton.addConstraintWidth(24, height: 44)
        favoriteButton.setImage(IconName.iconCallPhone, for: .normal)
        favoriteButton.tintColor = UIColor.white
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteBarItem), for: .touchUpInside)
        
        let favoriteView = UIView()
        favoriteView.backgroundColor = UIColor.clear
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        favoriteView.addSubview(favoriteButton)
        favoriteButton.fillSuperview()
        
        let favoriteBarItem = UIBarButtonItem(customView: favoriteView)
        navigationItem.rightBarButtonItem = favoriteBarItem
    }
}

// MARK: - Navigation items Action Handler
extension BaseViewController {
    @objc func didTapBackLeftBarItem() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapReloadBarItem() {}
    
    @objc func didTapFavoriteBarItem() {}
}

// MARK: - UIGestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
