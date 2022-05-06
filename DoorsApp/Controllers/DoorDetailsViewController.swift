//
//  DoorDetailsViewController.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 05.05.2022.
//

import UIKit

class DoorDetailsViewController: UIViewController {
    
    var doorModel: DoorModel?
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var snapshotView: UIImageView!
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        configure()
    }
    
    func configure() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        if let doorModel = doorModel {
            titleText.text = doorModel.name
            
            openView.layer.cornerRadius = 10.0
            
            snapshotView.layer.cornerRadius = 10.0
            
            snapshotView.image = nil
            
            // todo: maybe move out all of the snapshot views into a single view
            if let snapshot = doorModel.snapshot, let url = URL(string: snapshot) {
                NetworkService.shared.downloadImage(cached: true, url: url) { snapshotImage in
                    if let snapshotImage = snapshotImage {
                        self.snapshotView.isHidden = false
                        
                        self.snapshotView.image = snapshotImage
                    }
                }
            }
            
            if snapshotView.image == nil {
                snapshotView.isHidden = true
            }
        }
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}
