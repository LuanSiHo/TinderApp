//
//  CardListView.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

protocol CardListDataSource {
    func numberOfCards() -> Int
    func card(at index: Int) -> CardView
    func emptyView() -> UIView?
}

class CardListView: BaseUIView {
    private let horizontalInset: CGFloat = 10.0
    private let verticalInset: CGFloat = 10.0
    
    private var numberOfCards: Int = 0
    private var numberOfVisibleCards: Int = 3
    private var numberOfInvisibleCards: Int = 0
    
    private var cardViewList: [CardView] = []
    private var visibleCardViewList: [CardView] {
        return subviews as? [CardView] ?? []
    }
    
    var dataSource: CardListDataSource? {
        didSet {
            reloadData()
        }
    }
    
    override func initComponents() {
        super.initComponents()
    }

    func reloadData() {
        removeAllCardViews()
        layoutIfNeeded()
        guard let datasource = dataSource else { return }
        numberOfCards = datasource.numberOfCards()
        numberOfInvisibleCards = numberOfCards

        for index in 0..<min(numberOfCards, numberOfVisibleCards) {
            add(card: datasource.card(at: index), at: index)
        }
    }
}

// MARK: - Private function
extension CardListView {
    
    private func add(card: CardView, at index: Int) {
        card.delegate = self
        updateFrame(for: card, at: index)
        cardViewList.append(card)
        insertSubview(card, at: 0)
        numberOfInvisibleCards -= 1
    }
    
    private func updateFrame(for card: CardView, at index: Int) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        
        card.frame = cardViewFrame
    }
    
    private func removeAllCardViews() {
        removeAllVisibleCard()
        removeAllCardData()
    }
    
    private func removeAllVisibleCard() {
        for cardView in visibleCardViewList {
            cardView.removeFromSuperview()
        }
    }
    
    private func removeAllCardData() {
        cardViewList.removeAll()
    }
}

// MARK: - CardViewDelegate, Swipe Card Handler
extension CardListView: CardViewDelegate {
    func didSwipeLeft(on view: CardView) {
        didEndSwipe(on: view)
    }
    
    func didSwipeRight(on view: CardView) {
        didEndSwipe(on: view)
    }
    
    private func didEndSwipe(on card: CardView) {
        guard let datasource = dataSource else { return }
        card.removeFromSuperview()
        
        if numberOfInvisibleCards > 0 {
            // there are still cards that is not showing
            // get top invisible card index
            let index = datasource.numberOfCards() - numberOfInvisibleCards
            // add to last position of visible list
            add(card: datasource.card(at: index), at: numberOfVisibleCards - 1)
        }
        updateVisibleCardListUI()
    }
    
    private func updateVisibleCardListUI() {
        for (cardIndex, cardView) in visibleCardViewList.reversed().enumerated() {
            UIView.animate(withDuration: 0.2, animations: {
                cardView.center = self.center
                self.updateFrame(for: cardView, at: cardIndex)
                self.layoutIfNeeded()
            })
        }
    }
}
