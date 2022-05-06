//
//  NetworkService.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 05.05.2022.
//

import UIKit

protocol ImageDownloaderProtocol {
    func downloadImage(url: URL, downloaded: @escaping (UIImage?) -> Void)
}

class CachedImageDownloader: ImageDownloaderProtocol {
    private var urlSession: URLSession
    
    private var imageCache: [URL : UIImage] = [:]
    
    init() {
        urlSession = ServiceCollection.shared.resolve(type: URLSession.self)!
    }
    
    func downloadImage(url: URL, downloaded: @escaping (UIImage?) -> Void) {
        if let image = imageCache[url] {
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
}
