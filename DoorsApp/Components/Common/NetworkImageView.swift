//
//  NetworkImageView.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 06.05.2022.
//

import UIKit

class NetworkImageView: UIImageView {
    var didSetImage: ((UIImage?) -> Void)?
    
    func configure(for url: URL) {
        NetworkService.shared.downloadImage(cached: true, url: url) { snapshotImage in
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
