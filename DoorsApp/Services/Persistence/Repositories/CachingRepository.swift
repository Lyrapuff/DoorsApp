//
//  CachingRepository.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 05.05.2022.
//

import Foundation
import RealmSwift

class CachingRepository<T: Object>: Repository {
    @Injected private var api: ApiClient
    @Injected private var uow: UnitOfWork
    
    func loadAll(loaded: @escaping ([T]?) -> Void) {
        let models = uow.realm.objects(T.self)
        
        if models.isEmpty {
            // load from api
            
            loadFromApi(api: api, loaded: loaded)
        }
        else {
            // load from cache
            
            loaded(Array(models))
        }
    }
    
    func loadFromApi(api: ApiClient, loaded: @escaping ([T]?) -> Void) {}
    
    func cache(models: [T]) {
        try! uow.write { realm in
            realm.add(models)
        }
    }
    
    func deleteAll() {
        try! uow.write { realm in
            realm.delete(realm.objects(T.self))
        }
    }
    
    func change(changer: () -> Void) {
        try! uow.write { realm in
            changer()
        }
    }
}
