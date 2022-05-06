//
//  TabBarModel.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation
import UIKit

class TabModel {
    var name: String = String()
    var controller: UIViewController
    
    init(name: String, controller: UIViewController) {
        self.name = name
        self.controller = controller
    }
}
