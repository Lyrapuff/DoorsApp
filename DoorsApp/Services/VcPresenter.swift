//
//  VcTransitioner.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 09.05.2022.
//

import Foundation
import UIKit

protocol VcPresenterProtocol {
    func transition<T>(
        presenter: UIViewController,
        storyboard: UIStoryboard,
        vcType: T.Type,
        configure: (T) -> Void
    ) where T: UIViewController
}

class VcPresenter: VcPresenterProtocol {
    func transition<T>(
        presenter: UIViewController,
        storyboard: UIStoryboard,
        vcType: T.Type,
        configure: (T) -> Void
    ) where T : UIViewController {
        let vc = storyboard.instantiateViewController(identifier: "\(vcType)")
        
        if let vc = vc as? T {
            configure(vc)
            
            presenter.present(vc, animated: true, completion: nil)
        }
    }
}
