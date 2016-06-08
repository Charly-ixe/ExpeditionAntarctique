//
//  File.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 30/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController, UIPageViewControllerDataSource, UIScrollViewDelegate, UIPageViewControllerDelegate
{
    var pageViewController : MessagesPageViewController?
    var currentIndex : Int = 0
    var currentDay: Int = 0
    var dio: Diorama?
    var pageViewControllerTop: CGFloat?
    var pageViewControllerHeight: CGFloat?
    
    var titles: [UIView] = []
    
    var controllers: [MessagesController] = []
    
    @IBOutlet weak var wrapperScrollView: UIScrollView!
    var diorama_height_start: CGFloat?
    var diorama_height_final: CGFloat?
    var player: AVAudioPlayer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let url = NSBundle.mainBundle().URLForResource("ambiance calme boucle", withExtension: "wav")!
        
        do {
            player = try AVAudioPlayer(contentsOfURL: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
        
        player!.numberOfLoops = -1
        
        wrapperScrollView.contentSize = CGSize(width: wrapperScrollView.frame.width, height: wrapperScrollView.frame.height * 2)
        
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
        
        for i in 0...3 {
            let wrapper = UIView()
            let title = UIImageView(image: UIImage(named: "day" + String(i + 1)))
            wrapper.addSubview(title)
            title.contentMode = UIViewContentMode.ScaleAspectFill
            self.titles.append(wrapper)
            self.view.addSubview(wrapper)
        }
        
        var cpt = 0
        
        let dayPadding: CGFloat = 40
        for title in titles {
            var height: CGFloat = 40
            for sub in title.subviews {
                if let v = sub as? UIImageView {
                    
                    let imageSize = v.image?.size
                    sub.frame = CGRectMake(dayPadding + self.view.frame.width * CGFloat(cpt), 40, self.view.frame.width - dayPadding * 2, ((self.view.frame.width - dayPadding * 2 ) * imageSize!.height) / imageSize!.width)
                    height += ((self.view.frame.width - dayPadding * 2 ) * imageSize!.height) / imageSize!.width
                }
            }
            
            title.frame = CGRectMake(0, 0, self.view.frame.width, height)
            

            cpt += 1
            print(title.frame)
        }
        
        wrapperScrollView.addSubview(dio!)
        wrapperScrollView.bringSubviewToFront(pageViewController!.view)
        
        pageViewControllerTop = wrapperScrollView.contentSize.height - pageViewControllerHeight!
        
        pageViewController!.view.frame = CGRectMake(0, pageViewControllerTop!, wrapperScrollView.frame.size.width, pageViewControllerHeight!);
        
        let bottomConstraint = NSLayoutConstraint(item: pageViewController!.view, attribute: .Bottom, relatedBy: .Equal, toItem: wrapperScrollView, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
                
        pageViewController?.delegate = self
        
        wrapperScrollView.backgroundColor = UIColor(red:0.94, green:0.97, blue:1.00, alpha:1.0)
        pageViewController?.view.backgroundColor = UIColor(red:0.94, green:0.97, blue:1.00, alpha:1.0)
        dio?.backgroundColor = UIColor(red:0.94, green:0.97, blue:1.00, alpha:1.0)
        
        
        pageViewController?.view.layer.masksToBounds = false
        pageViewController?.view.clipsToBounds = false
        
        
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
        self.currentDay = i-1
        self.pageViewController!.setViewControllers([self.viewControllerAtIndex(i)!], direction: .Forward, animated: true, completion: { finished in
            self.currentDay = i
        })
        
        self.wrapperScrollView.setContentOffset(CGPointZero, animated: true)
        
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
            self.controllers.last?.view.backgroundColor = UIColor(red:0.94, green:0.97, blue:1.00, alpha:1.0)
            self.controllers.last?.view.clipsToBounds = false
            self.controllers.last?.view.layer.masksToBounds = false
        }
        currentIndex = index
        
        return self.controllers[index]
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        let top = wrapperScrollView.frame.height * 1 + diorama_height_final!
        let scroll = top - wrapperScrollView.contentOffset.y
        
        let percentage = 100 - (scroll * 100 / top)
        
        let newY = top * percentage / 420
        
        
        for title in self.titles {
            let newX = CGFloat(currentDay) * self.view.frame.width * (-1)
            title.frame = CGRectMake(newX, 0 - wrapperScrollView.contentOffset.y, title.frame.width, title.frame.height)
        }
        
        if percentage >= 0 && percentage <= 100
        {
            self.dio!.frame = CGRectMake(0, newY, wrapperScrollView.frame.width, self.dio!.frame.height)
            
            self.dio!.sky.frame = CGRectMake(0, wrapperScrollView.contentOffset.y - newY, wrapperScrollView.frame.width, self.dio!.sky.frame.height)
            
            for layer in self.dio!.layers {
                
                var newX: CGFloat = CGFloat(currentDay) * wrapperScrollView.frame.width * (-1)
                let commonVariation =  percentage * top / 100
                
                let layerVariation = CGFloat(dio!.layers.count + 1 - layer.index) / 9
                
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
