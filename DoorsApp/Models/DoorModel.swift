//
//  DoorModel.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation
import RealmSwift

class DoorModel: Object {
    @Persisted var name: String = String()
    @Persisted var snapshot: String? = nil
    @Persisted var room: String = String()
    @Persisted var favorites: Bool = false
    
    private var snapshotImageCache: UIImage? = nil
}
