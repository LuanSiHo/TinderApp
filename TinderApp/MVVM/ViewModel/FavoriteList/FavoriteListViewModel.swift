//
//  FavoriteListViewModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

protocol FavoriteListViewModelDelegate: BaseViewModelDelegate {
    func hideRefreshControl()
}

class FavoriteListViewModel: BaseViewModel {
    private weak var delegate: FavoriteListViewModelDelegate?
    
    init(delegate: FavoriteListViewModelDelegate) {
        super.init(delegate: delegate)
        self.delegate = delegate
    }
    
    var favoriteList: [UserModel] = []
}

// MARK: - Database
extension FavoriteListViewModel {
    func getLocalFavoriteList(type: LoadDataType) {
        if type == .fetch {
            delegate?.showLoadingView()
        }
        
        let localFavoriteList = LocalFavoriteListManager.shared.getAll()
        if  localFavoriteList.isEmpty {
            // empty list
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.favoriteList = []
                strongSelf.delegate?.showNoDataView()
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.favoriteList = localFavoriteList
                strongSelf.delegate?.hideNoDataView()
            }
        }
        
        // stop loading, reload data
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if type == .reload {
                strongSelf.delegate?.hideRefreshControl()
            } else if type == .fetch {
                strongSelf.delegate?.hideLoadingView()
            }
            strongSelf.delegate?.reloadData()
        }
    }
}
