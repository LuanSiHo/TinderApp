//
//  FavoriteListViewController.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

class FavoriteListViewController: BaseViewController {
    private lazy var viewModel: FavoriteListViewModel = {
         return FavoriteListViewModel.init(delegate: self)
     }()
    
    private let cellId = "UserInfoTableViewCell"
    private var refreshControl = UIRefreshControl()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = ColorName.whiteColor
        
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: cellId)
        
        return tableView
    }()
        
    private lazy var noDataLabel: UILabel = {
        let noDataLabel = UILabel()
        noDataLabel.text = DefineString.noPeopleAroundMessage
        noDataLabel.textColor = ColorName.grayColor
        noDataLabel.textAlignment = .center
        noDataLabel.font = FontName.systemFont(ofSize: 14)
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return noDataLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteList(type: .fetch)
    }
    
    override func setupView() {
        super.setupView()

        setupTableView()
        setupNoDataLabel()
        addPullToRefresh()
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        setupNavigationFavoriteList()
    }
}

// MARK: - Private set up
extension FavoriteListViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.addConstraint(fromTop: 0, toBottom: 0)
        tableView.addConstraint(fromLeft: 0, toRight: 0)
    }
    
    private func setupNoDataLabel() {
         view.addSubview(noDataLabel)
         noDataLabel.addConstraintCenteringXY()
         noDataLabel.isHidden = true
     }
    
    private func addPullToRefresh() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    }
    
    @objc func handlePullToRefresh() {
        getFavoriteList(type: .reload)
    }
}

// MARK: - Database
extension FavoriteListViewController {
    func getFavoriteList(type: LoadDataType) {
        viewModel.getLocalFavoriteList(type: type)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.userModel = viewModel.favoriteList[indexPath.row]
        return cell
    }
}

// MARK: - FavoriteListViewModelDelegate
extension FavoriteListViewController: FavoriteListViewModelDelegate {
    func hideRefreshControl() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    override func showNoDataView() {
        DispatchQueue.main.async {
            self.noDataLabel.isHidden = false
        }
    }
    
    override func hideNoDataView() {
        DispatchQueue.main.async {
            self.noDataLabel.isHidden = true
        }
    }
    
    override func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
