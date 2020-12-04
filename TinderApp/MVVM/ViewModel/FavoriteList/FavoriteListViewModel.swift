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
    func getLocalFavoriteList(type: LoadDataType, by manager: LocalManager) {
        if type == .fetch {
            delegate?.showLoadingView()
        }
        
        let localFavoriteList = manager.getAll()
        if localFavoriteList.isEmpty {
            // empty list
            favoriteList = []
            delegate?.showNoDataView()
        } else {
            favoriteList = localFavoriteList as? [UserModel] ?? []
            delegate?.hideNoDataView()
        }
        
        // stop loading, reload data
        if type == .reload {
            delegate?.hideRefreshControl()
        } else if type == .fetch {
            delegate?.hideLoadingView()
        }
        delegate?.reloadData()
    }
}
