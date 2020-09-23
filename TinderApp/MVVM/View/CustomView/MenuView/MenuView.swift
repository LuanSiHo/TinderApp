//
//  MenuView.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit

protocol MenuViewDelegate: class {
    func didSelectItem(at IndexPath: IndexPath)
}

class MenuView: BaseUIView {
    
    private let imageList: [UIImage] = [IconName.iconPerson, IconName.iconCalendar, IconName.iconAddress, IconName.iconPhone]
    private let numberOfMenuItem: CGFloat = 4
    var horizontalBarLeadingAnchorConstraint: NSLayoutConstraint?
    weak var delegate: MenuViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func initComponents() {
        setupCollectionView()
        setupHorizontalBar()
    }
}

// MARK: - private function
extension MenuView {
    private func setupCollectionView() {
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellId)
        addSubview(collectionView)
        collectionView.fillSuperview()
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
    }
    
    private func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = ColorName.darkGreenColor
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalBarView)
        horizontalBarLeadingAnchorConstraint = horizontalBarView.leadingAnchor.constraint(equalTo: leadingAnchor)
        horizontalBarLeadingAnchorConstraint?.isActive = true
        horizontalBarView.addConstraint(fromTop: 0)
        horizontalBarView.addConstraintAlignViewWidth(self, mutipler: 1/numberOfMenuItem)
        horizontalBarView.addConstraintHeight(4)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MenuView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(numberOfMenuItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellId, for: indexPath) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = imageList[indexPath.item].withRenderingMode(.alwaysTemplate)
        cell.tintColor = ColorName.grayColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / numberOfMenuItem, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.horizontalBarLeadingAnchorConstraint?.constant = self.frame.width / numberOfMenuItem * CGFloat(indexPath.item)
        delegate?.didSelectItem(at: indexPath)
    }
}
