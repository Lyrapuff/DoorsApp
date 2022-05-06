//
//  DoorsRepository.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation

class DoorsRepository: CachingRepository<DoorModel> {
    
    override func loadFromApi(api: ApiClient, loaded: @escaping ([DoorModel]?) -> Void) {
        api.getDoors { response in
            // ok
            
            let doorModels = DoorsDoor.toDoorModels(doors: response.data)
            
            DispatchQueue.main.async {
                self.cache(models: doorModels)
                
                loaded(doorModels)
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
