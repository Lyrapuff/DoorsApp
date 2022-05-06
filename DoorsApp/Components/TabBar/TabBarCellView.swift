//
//  TabBarCellView.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation
import UIKit

class TabBarCellView: UICollectionViewCell {
    static var identifier = "TabBarCellView"
    
    static func nib() -> UINib {
        UINib(nibName: "TabBarCellView", bundle: nil)
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var indicator: UIView!
    
    let selectedColor = UIColor(red: 42.0 / 255.0, green: 179.0 / 255.0, blue: 245.0 / 255.0, alpha: 1)
    
    func configure(for tabModel: TabModel, selected: Bool) {
        title.text = tabModel.name
        
        indicator.backgroundColor = selected ? selectedColor : .systemGray3
    }
}
