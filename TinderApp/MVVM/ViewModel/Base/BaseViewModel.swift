//
//  BaseViewModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

protocol BaseProtocol: class {}

protocol NoDataProtocol: class {
    func showNoDataView()
    func hideNoDataView()
}

protocol LoadingProtocol: class  {
    func showLoadingView()
    func hideLoadingView()
}

protocol BaseViewModelDelegate: LoadingProtocol, NoDataProtocol {
    func reloadData()
    func showErrorView(error: ErrorType)
}

class BaseViewModel: BaseProtocol {
    private weak var delegate: BaseViewModelDelegate?

    init(delegate: BaseViewModelDelegate) {
        self.delegate = delegate
    }
}
