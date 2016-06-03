//
//  File.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 30/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPageViewControllerDataSource
{
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var dio: Diorama?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
                
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: MessagesController = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        
        let diorama_height: CGFloat = 0.3
        
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, view.frame.size.height -  view.frame.size.height * (1 - diorama_height ), view.frame.size.width, view.frame.size.height * (1 - diorama_height ));
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        dio = Diorama(frame: CGRectMake(0, 0, self.view.frame.width, view.frame.size.height * diorama_height))
        
        self.view.addSubview(dio!)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! MessagesController).day
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! MessagesController).day
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if ModelController.Model.days.count >= index + 1
        {
            return viewControllerAtIndex(index)
        }
        return nil
    }
    
    func viewControllerAtIndex(index: Int) -> MessagesController?
    {
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("Messages") as! MessagesController
        pageContentViewController.day = index
        currentIndex = index
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 1
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
}
