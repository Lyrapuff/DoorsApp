//
//  Cameras.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 02.05.2022.
//

import Foundation

class Cameras: Codable {
    var success: Bool
    var data: CamerasData
}

class CamerasData: Codable {
    var room: [String]
    var cameras: [CamerasCamera]
}

class CamerasCamera: Codable {
    var name: String
    var snapshot: String
    var room: String?
    var id: Int
    var favorites: Bool
    var rec: Bool
}

extension CamerasCamera {
    func toCameraModel() -> CameraModel {
        let cameraModel = CameraModel()
        cameraModel.name = name
        cameraModel.room = room ?? "Другие"
        cameraModel.snapshot = snapshot
        cameraModel.favorites = favorites
        
        return cameraModel
    }
    
    static func toCameraModels(cameras: [CamerasCamera]) -> [CameraModel] {
        var cameraModels: [CameraModel] = []
        
        for camera in cameras {
            cameraModels.append(camera.toCameraModel())
        }
        
        return cameraModels
    }
}
