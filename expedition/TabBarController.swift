//
//  TabBarController.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 01/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var currentItem: UITabBarItem?
    
    override func viewDidLoad() {
        currentItem = self.tabBar.items![1]
        
        
        self.tabBar.items![1].selectedImage = UIImage(named: "Message")
        self.tabBar.items![0].selectedImage = UIImage(named: "Map")
        self.tabBar.items![2].selectedImage = UIImage(named: "Info")
        
        self.tabBar.tintColor = waterSkyBlue
        
        badgeEvent.once { str in
            self.setMessagesBadge()
        }
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        self.currentItem = item
        if item == self.tabBar.items![1]
        {
            self.removeMessagesBadge()
        }
    }
    
    // UITabBarControllerDelegate
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected view controller")
    }
    
    func setMessagesBadge(s: String = "")
    {
        if self.currentItem != self.tabBar.items![1]
        {
            self.tabBar.items![1].badgeValue = s
        }
        
        badgeEvent.once { str in
            self.setMessagesBadge()
        }
    }
    
    func removeMessagesBadge(s: String = "")
    {
        self.tabBar.items![1].badgeValue = nil
        
    }
}
