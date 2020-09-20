//
//  TinderListViewController.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

class TinderListViewController: BaseViewController {
    var viewModelData: [CardsDataModel] = [
        CardsDataModel(bgColor: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0), text: "Hamburger", image: "hamburger"),
                         CardsDataModel(bgColor: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0), text: "Puppy", image: "puppy"),
                         CardsDataModel(bgColor: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0), text: "Poop", image: "poop"),
                         CardsDataModel(bgColor: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0), text: "Panda", image: "panda"),
                         CardsDataModel(bgColor: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0), text: "Subway", image: "subway"),
                         CardsDataModel(bgColor: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0), text: "Robot", image: "robot"),
    ]
    
    private lazy var cardListView: CardListView = {
        let cardListView = CardListView()
        cardListView.translatesAutoresizingMaskIntoConstraints = false
        return cardListView
    }()
    
    private func setupCardListView() {
        cardListView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardListView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        cardListView.heightAnchor.constraint(equalToConstant: ScreenSize.height * 0.6).isActive = true
        cardListView.addConstraint(fromLeft: 20, toRight: 20)
        cardListView.dataSource = self
    }
}

// MARK: - Life cycle
extension TinderListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Set up
extension TinderListViewController {
    override func setupView() {
        super.setupView()
        view.backgroundColor = ColorName.whiteColor
        view.addSubview(cardListView)
        setupCardListView()
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        setupNavigationTinderList()
    }
    
    override func didTapReloadBarItem() {
        cardListView.reloadData()
    }
}

extension TinderListViewController: CardListDataSource {
    func numberOfCards() -> Int {
        return viewModelData.count
    }
    
    func card(at index: Int) -> CardView {
        let card = CardView()
        card.dataSource = viewModelData[index]
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
}

struct CardsDataModel {
    
    var bgColor: UIColor
    var text : String
    var image : String
      
    init(bgColor: UIColor, text: String, image: String) {
        self.bgColor = bgColor
        self.text = text
        self.image = image
    
    }
}
