//
//  ViewController.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 02.05.2022.
//

import UIKit

class CamerasViewController: UIViewController {

    let camerasRepository = CamerasRepository(api: RestApiClient.shared, uow: UnitOfWork.shared)
    
    var cameraGroups: [CameraGroup] = [] {
        didSet {
            camerasTableView.configure(for: cameraGroups)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var camerasTableView: CamerasTableView {
        tableView as! CamerasTableView
    }
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeData()
        
        configureRefreshControl()
        
        configureTable()
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните для обновления")
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData(_ sender: AnyObject) {
        cameraGroups.removeAll()
        camerasRepository.deleteAll()
        
        camerasRepository.loadAll { cameraModels in
            self.refreshControl.endRefreshing()
            
            if let cameraModels = cameraModels {
                self.cameraGroups = CameraGroup.fromCameraModels(cameraModels)
                self.tableView.reloadData()
            }
        }
    }
    
    func initializeData() {
        camerasRepository.loadAll { cameraModels in
            if let cameraModels = cameraModels {
                self.cameraGroups = CameraGroup.fromCameraModels(cameraModels)
            }
        }
    }
    
    func configureTable() {
        camerasTableView.didFavorite = tableDidFavorite
    }
    
    func tableDidFavorite(cameraModel: CameraModel) {
        camerasRepository.change {
            cameraModel.favorites.toggle()
        }
    }
}
