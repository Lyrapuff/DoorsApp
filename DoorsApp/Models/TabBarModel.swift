//
//  TabBarModel.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation

class TabModel {
    var name: String = String()
    
    init(name: String) {
        self.name = name
    }
}

extension TabModel {
    static func testData() -> [TabModel] {
        let tabs: [TabModel] = [
            TabModel(name: "Камеры"),
            TabModel(name: "Двери")
        ]
        
        return tabs
    }
}
