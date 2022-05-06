//
//  ApiClient.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 03.05.2022.
//

import Foundation

class RestApiClient: ApiClient {
    public static var shared = RestApiClient()
    
    private let baseUrl = "https://cars.cprogroup.ru/api/rubetek/"
    
    private var urlSession = ServiceCollection.shared.resolve(type: URLSession.self)!
    
    func get<T: Codable>(
        method: String,
        got: @escaping (T) -> Void,
        err: ErrorCallback?
    ) {
        let url = URL(string: baseUrl + method + "/")
        
        if let url = url {
            let task = urlSession.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    err?(ApiError(message: error.localizedDescription))
                    
                    return
                }
                
                if let data = data {
                    let decoded = try? JSONDecoder().decode(T.self, from: data)
                    
                    if let decoded = decoded {
                        got(decoded)
                    }
                    else {
                        err?(ApiError(message: "Failed to decode json"))
                    }
                }
                else {
                    err?(ApiError(message: "No data received"))
                }
            }
            
            task.resume()
        }
    }
    
    func getCameras(
        _ got: @escaping (Cameras) -> Void,
        _ err: ErrorCallback? = nil
    ) {
        get(method: "cameras", got: got, err: err)
    }
    
    func getDoors(
        _ got: @escaping (Doors) -> Void,
        _ err: ErrorCallback?
    ) {
        get(method: "doors", got: got, err: err)
    }
}
