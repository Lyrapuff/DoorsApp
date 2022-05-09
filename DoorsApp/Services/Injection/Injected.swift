//
//  Injected.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 09.05.2022.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    private var service: T!
    private var serviceCollection: ServiceCollectionProtocol
    
    init() {
        serviceCollection = ServiceCollection.shared
    }
    
    public var wrappedValue: T {
        mutating get {
            if service == nil {
                service = serviceCollection.resolve(type: T.self)
            }
            
            return service
        }
        
        mutating set {
            service = newValue
        }
    }
}
