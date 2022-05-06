//
//  CamerasRepository.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation

class CamerasRepository: CachingRepository<CameraModel> {
    
    override func loadFromApi(api: ApiClient, loaded: @escaping ([CameraModel]?) -> Void) {
        api.getCameras { response in
            // ok
            
            let cameraModels = CamerasCamera.toCameraModels(cameras: response.data.cameras)
            
            DispatchQueue.main.async {
                self.cache(models: cameraModels)
                
                loaded(cameraModels)
            }
        } _: {err in
            // failed
            
            err.debug()
            
            DispatchQueue.main.async {
                loaded(nil)
            }
        }
    }
}
