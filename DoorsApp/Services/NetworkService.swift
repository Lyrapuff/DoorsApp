//
//  NetworkService.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 05.05.2022.
//

import UIKit

class NetworkService {
    static var shared = NetworkService()
    
    private var urlSession = URLSession.shared
    
    private var imageCache: [URL : UIImage] = [:]
    
    func downloadImage(cached: Bool, url: URL, downloaded: @escaping (UIImage?) -> Void) {
        if cached, let image = imageCache[url] {
            downloaded(image)
            return
        }
        
        let task = urlSession.dataTask(with: url) {(data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    // done here to prevent synchronization issues (in case they may arise here)
                    if image != nil {
                        self.imageCache[url] = image
                    }
                    
                    downloaded(image)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                downloaded(nil)
            }
        }
        
        task.resume()
    }
    
    func clearImageCache() {
        imageCache.removeAll()
    }
}
