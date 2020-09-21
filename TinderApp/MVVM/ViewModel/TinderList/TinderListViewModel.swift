//
//  TinderListViewModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

protocol TinderListViewModelDelegate: BaseViewModelDelegate {
    func showNoDataView()
    func hideNoDataView()
}

class TinderListViewModel: BaseViewModel {
    private weak var delegate: TinderListViewModelDelegate?
    private lazy var apiService: TinderListApiService = {
        return TinderListApiService(delegate: self)
    }()
    
    init(delegate: TinderListViewModelDelegate) {
        super.init(delegate: delegate)
        self.delegate = delegate
    }
    
    var userList: [UserModel] = []
}

// MARK: - API request
extension TinderListViewModel {
    func loadUserList() {
        // check network
        if !AlamofireManager.isNetworkAvailable {
            delegate?.showErrorView(error: .noInternetError)
            return
        }
        
        delegate?.showLoadingView()
        
        let userListParam = UserListParam()
        userListParam.numberOfResult = 50
        
        apiService.loadUserList(param: userListParam) { [weak self] (response) in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let responseJson):
                if let userList = UserListModel(JSON: responseJson), userList.items.count != 0 {
                    // user list is not empty
                    strongSelf.userList = userList.items
                    strongSelf.delegate?.hideNoDataView()
                } else {
                    // empty list
                    strongSelf.userList = []
                    strongSelf.delegate?.showNoDataView()
                }
                strongSelf.delegate?.hideLoadingView()
                strongSelf.delegate?.reloadData()
                break
            case .failure(let error):
                strongSelf.delegate?.hideLoadingView()
                strongSelf.delegate?.showErrorView(error: .customeError(error: error))
                strongSelf.delegate?.showNoDataView()
                break
            }
        }
    }
}
