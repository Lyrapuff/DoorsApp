//
//  DoorEditViewController.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 05.05.2022.
//

import UIKit

class DoorEditViewController: UIViewController {
    
    var didSave: (() -> Void)?
    
    var doorModel: DoorModel?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var snapshotView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        configure()
    }
    
    func configure() {
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        
        nameField.becomeFirstResponder()
        
        if let doorModel = doorModel {
            nameField.text = doorModel.name
            
            snapshotView.layer.cornerRadius = 10.0
            
            snapshotView.image = nil
            
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
    
    @objc func savePressed() {
        didSave?()
        dismiss(animated: true, completion: nil)
    }
}
