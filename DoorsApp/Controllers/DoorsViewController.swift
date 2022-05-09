//
//  DoorsViewController.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import UIKit

class DoorsViewController: UIViewController {
    @Injected private var vcPresenter: VcPresenterProtocol
    @Injected private var doorsRepository: CachingRepository<DoorModel>
    
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
        if let storyboard = storyboard {
            vcPresenter.transition(presenter: self, storyboard: storyboard, vcType: DoorEditViewController.self) { vc in
                vc.doorModel = doorModel
                
                vc.didSave = {
                    self.doorsRepository.change {
                        doorModel.name = vc.nameField.text ?? doorModel.name
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableViewDidPress(doorModel: DoorModel) {
        if let storyboard = storyboard {
            vcPresenter.transition(presenter: self, storyboard: storyboard, vcType: DoorDetailsViewController.self) { vc in
                vc.doorModel = doorModel
            }
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
