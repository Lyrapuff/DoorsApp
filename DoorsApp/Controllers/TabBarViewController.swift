//
//  TabBarViewController.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import UIKit

class TabBarViewController: UIViewController {
    var tabModels: [TabModel] = []
    
    var selectedTab: Int? = 0 {
        didSet {
            if oldValue == selectedTab {
                return
            }
            
            switchTab(from: oldValue, to: selectedTab)
        }
    }
    
    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        tabBarView.tabs = tabModels
        
        tabBarView.didSelectTab = tabBarDidSelectTab
    }
    
    override func viewDidAppear(_ animated: Bool) {
        add(tabModels[0].controller)
    }
    
    func tabBarDidSelectTab(selected: Int) {
        selectedTab = selected
    }
    
    func switchTab(from: Int?, to: Int?) {
        if let from = from, let to = to {
            let from = tabModels[from].controller
            let to = tabModels[to].controller
            
            remove(from)
            add(to)
        }
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
          child.view.frame = frame
        }

        child.view.bounds = containerView.bounds
        
        containerView.addSubview(child.view)
        containerView.sendSubviewToBack(child.view)
        
        child.didMove(toParent: self)
    }
    
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
