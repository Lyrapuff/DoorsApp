//
//  AppConfigurator.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 06.05.2022.
//

import UIKit
import RealmSwift

class AppConfigurator {
    func configureServices(serviceCollection: ServiceCollectionProtocol) {
        serviceCollection.register(type: VcPresenterProtocol.self, instance: VcPresenter())
        
        serviceCollection.register(type: Realm.self, instance: try! Realm())
        
        serviceCollection.register(type: URLSession.self, instance: URLSession.shared)
        
        serviceCollection.register(type: CachedImageDownloaderProtocol.self, instance: CachedImageDownloader())
        
        serviceCollection.register(type: ApiClient.self, instance: RestApiClient())
        
        serviceCollection.register(type: UnitOfWork.self, instance: UnitOfWork())
        
        serviceCollection.register(type: CachingRepository<CameraModel>.self, instance: CamerasRepository())
        serviceCollection.register(type: CachingRepository<DoorModel>.self, instance: DoorsRepository())
    }
    
    func launch(window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        
        let tabModels = [
            TabModel(name: "Камеры", controller: storyboard.instantiateViewController(withIdentifier: "CamerasViewController")),
            TabModel(name: "Двери", controller: storyboard.instantiateViewController(withIdentifier: "DoorsViewController"))
        ]
        
        tabBar.tabModels = tabModels
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}
