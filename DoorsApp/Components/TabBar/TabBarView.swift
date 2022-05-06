//
//  TabBarView.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation
import UIKit

class TabBarView: UIView {
    var didSelectTab: ((Int) -> Void)?
    
    var tabs: [TabModel] = [] {
        didSet {
            collection.reloadData()
        }
    }
    var selectedIndex = 0
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.dataSource = self
        collection.delegate = self
        
        collection.isScrollEnabled = false
        
        collection.register(TabBarCellView.nib(), forCellWithReuseIdentifier: TabBarCellView.identifier)
        
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
        style()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        
        style()
    }
    
    func configure() {
        addSubview(collection)
    }
    
    func style() {
        collection.backgroundColor = .systemGray6
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let tabbarHeight = safeAreaInsets.bottom + 50
        
        collection.frame = .init(
          x: 0,
          y: bounds.height - tabbarHeight,
          width: bounds.width,
          height: tabbarHeight
        )
    }
}

extension TabBarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
          width: collectionView.bounds.width / CGFloat(tabs.count),
          height: collectionView.bounds.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
        
        didSelectTab?(indexPath.item)
    }
}

extension TabBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCellView.identifier, for: indexPath) as! TabBarCellView
        
        let tabModel = tabs[indexPath.item]
        let selected = selectedIndex == indexPath.item
        
        cell.configure(for: tabModel, selected: selected)
        
        return cell;
    }
}
