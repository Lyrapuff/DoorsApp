//
//  DoorsTableViewCell.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import UIKit

// todo: maybe resuse these cells?
class DoorsTableViewCell: UITableViewCell {
    static let identifier = "DoorsTableViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: "DoorsTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var snapshotImage: NetworkImageView!
    @IBOutlet weak var dim: UIView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var snapshotView: UIView!
    
    public func configure(doorModel: DoorModel) {
        title.text = doorModel.name
    
        star.isHidden = !doorModel.favorites
        
        dim.layer.cornerRadius = 10.0
        dim.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        stackView.layer.cornerRadius = 10.0
        
        // oh no I'm wasting precious memory on generating closures each time unu who cares about memory anyway? well maybe I do..
        snapshotImage.didSetImage = NetworkImageView.hideIfNil(what: snapshotView)
        
        if let snapshot = doorModel.snapshot, let url = URL(string: snapshot) {
            snapshotImage.configure(for: url)
        }
        
        snapshotImage.layer.cornerRadius = 10.0
        snapshotImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
