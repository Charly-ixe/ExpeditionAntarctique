//
//  MessagesPageViewController.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 04/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class MessagesPageViewController: UIPageViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle,
                                  navigationOrientation navigationOrientation: UIPageViewControllerNavigationOrientation,
                                                        options options: [String : AnyObject]?) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        print("Init")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("moved")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("began")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ended")
    }
    
}
