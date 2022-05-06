//
//  CameraModel.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 02.05.2022.
//

import Foundation
import RealmSwift

class CameraGroup {
    var room: String = String()
    var cameras: [CameraModel] = []
}

extension CameraGroup {
    static func fromCameraModels(_ cameraModels: [CameraModel]) -> [CameraGroup] {
        var groups: [CameraGroup] = []
        
        for cameraModel in cameraModels {
            var group = groups.first(where: {group in group.room == cameraModel.room})
            
            if group == nil {
                // new group
                
                group = CameraGroup()
                
                if let group = group {
                    group.room = cameraModel.room
                    group.cameras = []
                    
                    groups.append(group)
                }
            }
            
            if let group = group {
                group.cameras.append(cameraModel)
            }
        }
        
        return groups
    }
}

class CameraModel: Object {
    @objc dynamic var name: String = String()
    @objc dynamic var snapshot: String = String()
    @objc dynamic var room: String = String()
    @objc dynamic var favorites: Bool = false
}

extension CameraModel {
    static func testData() -> [CameraModel] {
        let camera1 = CameraModel();
        camera1.name = "Camera 1"
        camera1.snapshot = "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png"
        camera1.room = "Kitchen"
        
        let camera2 = CameraModel()
        camera2.name = "Camera 2"
        camera2.snapshot = "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png"
        camera2.room = "Hall"
        
        return [camera1, camera2]
    }
}
