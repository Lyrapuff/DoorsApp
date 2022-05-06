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
    @IBOutlet weak var snapshotView: NetworkImageView!
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
            
            snapshotView.didSetImage = NetworkImageView.hideIfNil(what: snapshotView)
            
            if let snapshot = doorModel.snapshot, let url = URL(string: snapshot) {
                snapshotView.configure(for: url)
            }
        }
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}
