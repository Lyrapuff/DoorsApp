//
//  CameraTableViewCell.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 02.05.2022.
//

import UIKit

class CameraTableViewCell: UITableViewCell {

    static let identifier = "CameraTableViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: "CameraTableViewCell", bundle: nil)
    }

    @IBOutlet var snapshotImage: NetworkImageView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var dim: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    func configure(for model: CameraModel) {
        label.text = "  " + model.name
        
        if let url = URL(string: model.snapshot) {
            snapshotImage.configure(for: url)
            
            star.isHidden = !model.favorites
        }
        
        stackView.layer.cornerRadius = 10.0
        stackView.layer.masksToBounds = true
    }
}
