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
    
    @Injected var realm: Realm
    
    func work(worker: (Realm) -> Void) {
        worker(realm)
    }
    
    func write(writer: (Realm) -> Void) throws {
        try realm.write {
            writer(realm)
        }
    }
}
