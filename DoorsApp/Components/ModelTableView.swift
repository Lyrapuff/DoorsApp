//
//  ModelTableView.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 06.05.2022.
//

import UIKit

class ModelTableView<T>: UITableView {
    var models: [T] = []
    
    func getModel(index: Int) -> T? {
        if index >= models.count {
            return nil
        }
        
        return models[index]
    }
    
    func configure(for models: [T]) {
        self.models = models
    }
}
