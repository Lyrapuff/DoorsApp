//
//  DoorsViewController.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import UIKit

class DoorsViewController: UIViewController {
    var doorsRepository = DoorsRepository(api: RestApiClient.shared, uow: UnitOfWork.shared)
    
    var doorModels: [DoorModel] = [] {
        didSet {
            doorsTableView.configure(for: doorModels)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var doorsTableView: DoorsTableView {
        tableView as! DoorsTableView
    }
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        initializeData()
        
        configureRefreshControl()
        
        doorsTableView.didFavorite = tableViewDidFavorite
        doorsTableView.didEdit = tableViewDidEdit
        doorsTableView.didPress = tableViewDidPress
    }
    
    func tableViewDidFavorite(doorModel: DoorModel) {
        doorsRepository.change {
            doorModel.favorites.toggle()
        }
    }
    
    func tableViewDidEdit(doorModel: DoorModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoorEditViewController")
        
        if let vc = vc as? DoorEditViewController {
            vc.doorModel = doorModel
            
            vc.didSave = {
                self.doorsRepository.change {
                    doorModel.name = vc.nameField.text ?? doorModel.name
                }
                
                self.tableView.reloadData()
            }
            
            present(vc, animated: true, completion: nil)
        }
    }
    
    func tableViewDidPress(doorModel: DoorModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoorDetailsViewController")
        
        if let vc = vc as? DoorDetailsViewController {
            vc.doorModel = doorModel
            
            //present(vc, animated: true, completion: nil)
            show(vc, sender: self)
        }
    }
    
    func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните для обновления")
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData(_ sender: AnyObject) {
        doorModels.removeAll()
        doorsRepository.deleteAll()
        
        doorsRepository.loadAll { doorModels in
            self.refreshControl.endRefreshing()
            
            if let doorModels = doorModels {
                self.doorModels = doorModels
                self.tableView.reloadData()
            }
            else {
                print("Failed to refresh data")
            }
        }
    }
    
    func initializeData() {
        doorsRepository.loadAll { doorModels in
            if let doorModels = doorModels {
                self.doorModels = doorModels
                self.tableView.reloadData()
            }
        }
    }
}
