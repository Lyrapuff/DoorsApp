//
//  CamerasTableView.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation
import UIKit

class CamerasTableView: ModelTableView<CameraGroup> {
    var didFavorite: ((CameraModel) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        self.delegate = self
        self.dataSource = self
        
        register(CameraTableViewCell.nib(), forCellReuseIdentifier: CameraTableViewCell.identifier)
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 200
    }
    
    func favoriteAction(cell: CameraTableViewCell, model: CameraModel) -> UIContextualAction {
        let favoriteAction = UIContextualAction(style: .normal, title: "") { action, view, complete in
            self.didFavorite?(model)
            
            cell.configure(for: model)
            
            complete(true)
        }
        
        let starImage = model.favorites ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
        
        favoriteAction.image = starImage?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        favoriteAction.backgroundColor = .systemGray6
        
        return favoriteAction
    }
}

extension CamerasTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = getModel(index: section)
        
        return group?.room ?? ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .light)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = getModel(index: section)
        
        return group?.cameras.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CameraTableViewCell.identifier) as! CameraTableViewCell
        
        let group = getModel(index: indexPath.section)
        
        if let group = group {
            let camera = group.cameras[indexPath.row]
            
            cell.configure(for: camera)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let group = getModel(index: indexPath.section)
        
        if let group = group {
            let cameraModel = group.cameras[indexPath.row]
            
            let cell = tableView.cellForRow(at: indexPath) as! CameraTableViewCell
            
            let actions = [
                favoriteAction(cell: cell, model: cameraModel)
            ]
            
            let config = UISwipeActionsConfiguration(actions: actions)
            config.performsFirstActionWithFullSwipe = false
            
            return config
        }
        
        return nil
    }
}

extension CamerasTableView: UITableViewDelegate {
    
}
