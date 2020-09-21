//
//  BaseViewModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

protocol BaseViewModelDelegate: class {
    func showErrorView(error: ErrorType)
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

class BaseViewModel {
    private weak var delegate: BaseViewModelDelegate?

    init(delegate: BaseViewModelDelegate) {
        self.delegate = delegate
    }
}

extension BaseViewModel: BaseProtocol {
    func showErrorView(error: ErrorType) {}
    func showLoadingView() {}
    func hideLoadingView() {}
}
