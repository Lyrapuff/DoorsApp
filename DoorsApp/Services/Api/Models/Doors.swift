//
//  Doors.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation

class Doors: Codable {
    var success: Bool
    var data: [DoorsDoor]
}

class DoorsDoor: Codable {
    var name: String
    var snapshot: String?
    var room: String?
    var id: Int
    var favorites: Bool
}

extension DoorsDoor {
    func toDoorModel() -> DoorModel {
        let doorModel = DoorModel()
        
        doorModel.name = name
        doorModel.snapshot = snapshot
        doorModel.room = room ?? "Другие"
        doorModel.favorites = favorites
        
        return doorModel
    }
    
    static func toDoorModels(doors: [DoorsDoor]) -> [DoorModel] {
        var doorModels: [DoorModel] = []
        
        for door in doors {
            doorModels.append(door.toDoorModel())
        }
        
        return doorModels
    }
}
