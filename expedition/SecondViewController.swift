//
//  File.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 30/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPageViewControllerDataSource, UIScrollViewDelegate
{
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var dio: Diorama?
    var pageViewControllerTop: CGFloat?
    var pageViewControllerHeight: CGFloat?
    @IBOutlet weak var scrollview: UIScrollView!
    
    var diorama_height_start: CGFloat?
    var diorama_height_final: CGFloat?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        scrollview.contentSize = CGSize(width: scrollview.frame.width, height: scrollview.frame.height * 3)
        
        diorama_height_start = scrollview.frame.size.height * 1.0
        diorama_height_final = scrollview.frame.size.height / 4
        
        scrollview.delegate = self
                
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: MessagesController = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        
        
        pageViewControllerHeight = scrollview.frame.size.height - diorama_height_final!
        
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        
        addChildViewController(pageViewController!)
        scrollview.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        dio = Diorama(frame: CGRectMake(0, 0, scrollview.frame.width, diorama_height_start!))
        
        scrollview.addSubview(dio!)
        scrollview.bringSubviewToFront(pageViewController!.view)
        
        pageViewControllerTop = scrollview.contentSize.height - pageViewControllerHeight!
        
        pageViewController!.view.frame = CGRectMake(0, pageViewControllerTop!, scrollview.frame.size.width, pageViewControllerHeight!);

        
        let bottomConstraint = NSLayoutConstraint(item: pageViewController!.view, attribute: .Bottom, relatedBy: .Equal, toItem: scrollview, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
        
        scrollview.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let top = scrollview.frame.height * 2 + diorama_height_final!
        let scroll = top - scrollview.contentOffset.y
        
        print(top)
        print(scroll)
        
        let percentage = 100 - (scroll * 100 / top)
        
        print(percentage)
        
        print("-------------")
        
        let newY = top * percentage / 165
        
        if percentage >= 0 && percentage <= 100
        {
            self.dio!.frame = CGRectMake(0, newY, scrollview.frame.width, self.dio!.frame.height)
            
            self.dio!.sky.frame = CGRectMake(0, scrollview.contentOffset.y - newY, scrollview.frame.width, self.dio!.sky.frame.height)
            
            for layer in self.dio!.layers {
                
                let frm: CGRect = layer.frame
                
                let commonVariation =  percentage * top / 100
                
                let layerVariation = CGFloat(dio!.layers.count + 1 - layer.index) / 17
                
                layer.frame = CGRectMake(frm.origin.x, layer.yO! + commonVariation * layerVariation, layer.frame.width, layer.frame.height)
                
            }
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {    }
    
}
