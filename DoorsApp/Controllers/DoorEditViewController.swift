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
    @IBOutlet weak var snapshotView: NetworkImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        configure()
    }
    
    func configure() {
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        
        nameField.addTarget(self, action: #selector(savePressed), for: .primaryActionTriggered)
        
        nameField.becomeFirstResponder()
        
        if let doorModel = doorModel {
            nameField.text = doorModel.name
            
            snapshotView.layer.cornerRadius = 10.0
            
            snapshotView.didSetImage = NetworkImageView.hideIfNil(what: snapshotView)
            
            if let snapshot = doorModel.snapshot, let url = URL(string: snapshot) {
                snapshotView.configure(for: url)
            }
        }
    }
    
    @objc func savePressed() {
        didSave?()
        dismiss(animated: true, completion: nil)
    }
}
