//
//  TabBarViewController.swift
//  DoorsApp
//
//  Created by CPRO GROUP on 04.05.2022.
//

import UIKit

class TabBarViewController: UIViewController {
    var controllers: [UIViewController] = []
    var tabModels: [TabModel] = []
    
    var selectedTab: Int? = nil {
        didSet {
            if let oldValue = oldValue {
                remove(controllers[oldValue])
            }
            
            if let selectedTab = selectedTab {
                add(controllers[selectedTab])
            }
        }
    }
    
    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        tabBarView.tabs = tabModels
        
        tabBarView.didSelectTab = tabBarDidSelectTab
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedTab = 0
    }
    
    func tabBarDidSelectTab(selected: Int) {
        selectedTab = selected
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
