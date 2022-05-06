//
//  DoorsTableView.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import UIKit

class DoorsTableView: ModelTableView<DoorModel> {
    var didEdit: ((DoorModel) -> Void)?
    var didFavorite: ((DoorModel) -> Void)?
    var didPress: ((DoorModel) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        delegate = self
        dataSource = self
        
        register(DoorsTableViewCell.nib(), forCellReuseIdentifier: DoorsTableViewCell.identifier)
        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 200
    }
}

extension DoorsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoorsTableViewCell.identifier) as! DoorsTableViewCell
        
        let doorModel = getModel(index: indexPath.row)
        
        if let doorModel = doorModel {
            cell.configure(doorModel: doorModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let doorModel = getModel(index: indexPath.row)
        
        return doorModel?.snapshot != nil ? 265 : 65
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doorModel = getModel(index: indexPath.row)
        
        if let doorModel = doorModel {
            let cell = tableView.cellForRow(at: indexPath) as! DoorsTableViewCell
            
            // favorite
            let favoriteAction = UIContextualAction(style: .normal, title: "") { action, view, complete in
                self.didFavorite?(doorModel)
                
                cell.configure(doorModel: doorModel)
                
                complete(true)
            }
            
            let starImage = doorModel.favorites ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            
            favoriteAction.image = starImage?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            favoriteAction.backgroundColor = .systemGray6
            
            // edit
            let editAction = UIContextualAction(style: .normal, title: "") { action, view, complete in
                self.didEdit?(doorModel)
                
                complete(true)
            }
            
            let pencilImage = UIImage(systemName: "pencil")
            
            editAction.image = pencilImage?.withTintColor(.blue, renderingMode: .alwaysOriginal)
            editAction.backgroundColor = .systemGray6
            
            // config
            let config = UISwipeActionsConfiguration(actions: [favoriteAction, editAction])
            config.performsFirstActionWithFullSwipe = false
            
            return config
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doorModel = getModel(index: indexPath.row)
        
        if let doorModel = doorModel {
            didPress?(doorModel)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension DoorsTableView: UITableViewDelegate {
    
}
