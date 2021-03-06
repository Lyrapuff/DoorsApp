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
        
        // oh no I'm wasting precious memory on allocating closures each time unu who cares about memory anyway? well maybe I do..
        snapshotImage.didSetImage = NetworkImageView.hideIfNil(what: snapshotView)
        
        if let snapshot = doorModel.snapshot, let url = URL(string: snapshot) {
            snapshotImage.configure(for: url)
            
            star.isHidden = !doorModel.favorites
        }
        
        stackView.layer.cornerRadius = 10.0
        stackView.layer.masksToBounds = true
    }
}
