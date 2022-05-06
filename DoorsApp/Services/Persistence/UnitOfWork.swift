//
//  UnitOfWork.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation
import RealmSwift

class UnitOfWork {
    static var shared = UnitOfWork()
    
    var realm: Realm
    
    init() {
        realm = ServiceCollection.shared.resolve(type: Realm.self)!
    }
    
    func work(worker: (Realm) -> Void) {
        worker(realm)
    }
    
    func write(writer: (Realm) -> Void) {
        realm.beginWrite()
        
        writer(realm)
        
        try! realm.commitWrite()
    }
}
