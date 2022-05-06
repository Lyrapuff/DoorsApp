//
//  ApiClient.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import Foundation

class ApiError {
    var message: String
    
    init(message: String) {
        self.message = message;
    }
    
    func debug() {
        print("Error: \(message)")
    }
}

typealias ErrorCallback = (ApiError) -> Void

protocol ApiClient {
    func getCameras(
        _ got: @escaping (Cameras) -> Void,
        _ err: ErrorCallback?
    )
    
    func getDoors(
        _ got: @escaping (Doors) -> Void,
        _ err: ErrorCallback?
    )
}
