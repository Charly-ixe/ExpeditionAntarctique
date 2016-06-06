//
//  File.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 30/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPageViewControllerDataSource, UIScrollViewDelegate, UIPageViewControllerDelegate
{
    var pageViewController : MessagesPageViewController?
    var currentIndex : Int = 0
    var currentDay: Int = 0
    var dio: Diorama?
    var pageViewControllerTop: CGFloat?
    var pageViewControllerHeight: CGFloat?
    
    var controllers: [MessagesController] = []
    
    @IBOutlet weak var wrapperScrollView: UIScrollView!
    var diorama_height_start: CGFloat?
    var diorama_height_final: CGFloat?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        wrapperScrollView.contentSize = CGSize(width: wrapperScrollView.frame.width, height: wrapperScrollView.frame.height * 3)
        
        diorama_height_start = wrapperScrollView.frame.size.height * 1.0
        diorama_height_final = wrapperScrollView.frame.size.height / 4
        
        wrapperScrollView.delegate = self
        
        pageViewController = MessagesPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: MessagesController = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        
        pageViewControllerHeight = wrapperScrollView.frame.size.height - diorama_height_final!
        
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        
        addChildViewController(pageViewController!)
        
        wrapperScrollView.addSubview(pageViewController!.view)
        
        pageViewController!.didMoveToParentViewController(self)
        
        dio = Diorama(frame: CGRectMake(0, 0, wrapperScrollView.frame.width, diorama_height_start!))
        
        wrapperScrollView.addSubview(dio!)
        wrapperScrollView.bringSubviewToFront(pageViewController!.view)
        
        pageViewControllerTop = wrapperScrollView.contentSize.height - pageViewControllerHeight!
        
        pageViewController!.view.frame = CGRectMake(0, pageViewControllerTop!, wrapperScrollView.frame.size.width, pageViewControllerHeight!);
        
        let bottomConstraint = NSLayoutConstraint(item: pageViewController!.view, attribute: .Bottom, relatedBy: .Equal, toItem: wrapperScrollView, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
        
        wrapperScrollView.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        pageViewController?.delegate = self
        
        for v in pageViewController!.view.subviews {
            if let w = v as? UIScrollView {
                w.delegate = self
//                w.bounces = false
            }
        }
        
        newDayEvent.once { dayIndex in
            self.turnPage(dayIndex)
        }
        
    }
    
    func turnPage(i: Int) {
        self.currentDay = i
        self.pageViewController!.setViewControllers([self.viewControllerAtIndex(i)!], direction: .Forward, animated: true, completion: nil)
        
        newDayEvent.once{ dayIndex in
            self.turnPage(dayIndex)
        }
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
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let cont = pageViewController.viewControllers![0] as? MessagesController
        {
            currentDay = cont.day
        }
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
        if index >= self.controllers.count
        {
            self.controllers.append(UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("Messages") as! MessagesController)
            self.controllers.last?.day = index
        }
        currentIndex = index
        
        return self.controllers[index]
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //
        //        print(current)
        //        print(scrollView.contentOffset.x)
        print("***********************")
        print(scrollView.contentOffset)
        print(currentDay)
        
        let top = wrapperScrollView.frame.height * 2 + diorama_height_final!
        let scroll = top - wrapperScrollView.contentOffset.y
        
        let percentage = 100 - (scroll * 100 / top)
        
        let newY = top * percentage / 165
        
        if percentage >= 0 && percentage <= 100
        {
            self.dio!.frame = CGRectMake(0, newY, wrapperScrollView.frame.width, self.dio!.frame.height)
            
            self.dio!.sky.frame = CGRectMake(0, wrapperScrollView.contentOffset.y - newY, wrapperScrollView.frame.width, self.dio!.sky.frame.height)
            
            for layer in self.dio!.layers {
                
                let commonVariation =  percentage * top / 100
                
                let layerVariation = CGFloat(dio!.layers.count + 1 - layer.index) / 17
                var slide = layer.frame.width * wrapperScrollView.frame.width / (7 * wrapperScrollView.frame.width)
                
                var newX: CGFloat = CGFloat(currentDay) * wrapperScrollView.frame.width * (-1)
                if scrollView.contentOffset.x != 0 {
                    if scrollView.contentOffset.x == wrapperScrollView.frame.width {
//                        newX = -newX
                    }
                    else {
                        newX = newX - (scrollView.contentOffset.x - wrapperScrollView.frame.width)
                    }
                }
                
                layer.frame = CGRectMake(newX, layer.yO! + commonVariation * layerVariation, layer.frame.width, layer.frame.height)
                
            }
        }
    }
}
