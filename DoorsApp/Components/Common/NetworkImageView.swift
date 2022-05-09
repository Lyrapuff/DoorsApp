//
//  NetworkImageView.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 06.05.2022.
//

import UIKit

class NetworkImageView: UIImageView {
    var didSetImage: ((UIImage?) -> Void)?
    
    private var imageDownloader = ServiceCollection.shared.resolve(type: CachedImageDownloaderProtocol.self)!
    
    func configure(for url: URL, cached: Bool = false) {
        if !cached {
            imageDownloader.clearCache(for: url)
        }
        
        imageDownloader.downloadImage(url: url) { snapshotImage in
            if let snapshotImage = snapshotImage {
                self.image = snapshotImage
            }
            
            self.didSetImage?(snapshotImage)
        }
    }
    
    static func hideIfNil(what view: UIView) -> ((UIImage?) -> Void) {
        view.isHidden = true
        
        return {image in
            if image != nil {
                view.isHidden = false
            }
        }
    }
}
