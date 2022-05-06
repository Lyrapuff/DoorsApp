//
//  Repository.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation
import RealmSwift

protocol Repository {
    associatedtype T: Object
    
    func loadAll(loaded: @escaping ([T]?) -> Void)
    
    func deleteAll()
    
    func change(changer: () -> Void)
}
