//
//  TinderListViewController.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

class TinderListViewController: BaseViewController {
    private lazy var cardListView: CardListView = {
        let cardListView = CardListView()
        cardListView.translatesAutoresizingMaskIntoConstraints = false
        return cardListView
    }()
    
    private lazy var viewModel: TinderListViewModel = {
        return TinderListViewModel.init(delegate: self)
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
}

// MARK: - Life cycle
extension TinderListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserList()
        setupNoDataLabel()
    }
}

// MARK: - Set up
extension TinderListViewController {
    override func setupView() {
        super.setupView()
        view.backgroundColor = ColorName.whiteColor
        setupCardListView()
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        setupNavigationTinderList()
    }
    
    override func didTapReloadBarItem() {
        hideNoDataView()
        viewModel.loadUserList()
    }
    
    private func setupCardListView() {
        view.addSubview(cardListView)
        cardListView.addConstraintCenteringX()
        cardListView.addConstraintCenteringY(withOffset: -20)
        cardListView.addConstraintHeight(ScreenSize.height * 0.6)
        cardListView.addConstraint(fromLeft: 20, toRight: 20)
        cardListView.dataSource = self
    }
    
    private func setupNoDataLabel() {
        view.addSubview(noDataLabel)
        noDataLabel.addConstraintCenteringXY()
        noDataLabel.isHidden = true
    }
}

extension TinderListViewController {
    private func getUserList() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.loadUserList()
        }
    }
}

// MARK: - CardListDataSource
extension TinderListViewController: CardListDataSource {
    
    func numberOfCards() -> Int {
        return viewModel.userList.count
    }
    
    func card(at index: Int) -> CardView {
        let card = CardView()
        card.userInfo = viewModel.userList[index]
        return card
    }
    
    func showOutOfCardView() {
        showNoDataView()
    }
}

// MARK: - TinderListViewModelDelegate
extension TinderListViewController: TinderListViewModelDelegate {
    func showNoDataView() {
        DispatchQueue.main.async {
            self.noDataLabel.isHidden = false
        }
    }
    
    func hideNoDataView() {
        DispatchQueue.main.async {
            self.noDataLabel.isHidden = true
        }
    }
    
    override func reloadData() {
        DispatchQueue.main.async {
            self.cardListView.reloadData()
        }
    }
}
