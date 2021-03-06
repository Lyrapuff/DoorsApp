//
//  ServiceCollection.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 06.05.2022.
//

import Foundation

protocol ServiceCollectionProtocol {
    func register<T>(type: T.Type, instance: Any)
    
    func resolve<T>(type: T.Type) -> T?
}

class ServiceCollection: ServiceCollectionProtocol {
    static var shared = ServiceCollection()
    
    private var services: [String : Any] = [:]
    
    func register<T>(type: T.Type, instance: Any) {
        services["\(type)"] = instance
    }
    
    func resolve<T>(type: T.Type) -> T? {
        if !services.keys.contains("\(type)") {
            print("WARNING! Trying to resolve \("\(type)") but it was never registered")
        }
        
        return services["\(type)"] as? T
    }
}
