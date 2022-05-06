//
//  DoorsTableViewCell.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import UIKit

class DoorsTableViewCell: UITableViewCell {
    static let identifier = "DoorsTableViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: "DoorsTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var snapshotImage: UIImageView!
    @IBOutlet weak var dim: UIView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var snapshotView: UIView!
    
    public func configure(doorModel: DoorModel) {
        title.text = doorModel.name
        
        snapshotImage.image = nil
        
        if let snapshot = doorModel.snapshot, let url = URL(string: snapshot) {
            NetworkService.shared.downloadImage(cached: true, url: url) { snapshotImage in
                if let snapshotImage = snapshotImage {
                    self.snapshotView.isHidden = false
                    
                    self.snapshotImage.image = snapshotImage
                }
            }
        }
        
        if snapshotImage.image == nil {
            snapshotView.isHidden = true
        }
        
        snapshotImage.layer.cornerRadius = 10.0
        snapshotImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
        star.isHidden = !doorModel.favorites
        
        dim.layer.cornerRadius = 10.0
        dim.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        stackView.layer.cornerRadius = 10.0
    }
}
