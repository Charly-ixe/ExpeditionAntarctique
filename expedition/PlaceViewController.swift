//
//  PlaceViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 02/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UIPageViewControllerDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    var pageViewController : UIPageViewController?
    var pageImages : Array<String> = ["photo_avant_poste.jpg", "photo_zodiac.jpg", "photo_pingouin.jpg"]
    var currentIndex : Int = 0
    var titleView : UIView?
    var typeLabel : UILabel = UILabel()
    var titleLabel : UILabel = UILabel()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: CarouselView = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height / 2);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        titleView = UIVisualEffectView(effect: blurEffect)
        titleView!.frame = CGRectMake(12, pageViewController!.view.frame.height - 70, self.view.frame.width - 24, 100)
        titleView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.view.addSubview(titleView!)
        
        typeLabel.frame = CGRectMake(0, 15, titleView!.frame.width, 14)
        typeLabel.text = "BASE"
        typeLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        typeLabel.textColor = nunatakBlackAlpha
        typeLabel.textAlignment = .Center
        titleView!.addSubview(typeLabel)
        
        titleLabel.frame = CGRectMake(0, 40, titleView!.frame.width, 34)
        titleLabel.text = "Dumont d'Urville"
        titleLabel.font = UIFont(name: "AvenirNext-Regular", size: 32)
        titleLabel.textColor = nunatakBlack
        titleLabel.textAlignment = .Center
        titleView!.addSubview(titleLabel)

    }
    
    override func viewDidAppear(animated: Bool) {
        titleView!.clipsToBounds = false
        titleView!.layer.masksToBounds = false
        self.titleView!.layer.shadowOpacity = 0.2
        self.titleView!.layer.shadowColor = brashWhite.CGColor
        self.titleView!.layer.shadowOffset = CGSizeZero
        self.titleView!.layer
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CarouselView).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CarouselView).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == self.pageImages.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> CarouselView? {
        if self.pageImages.count == 0 || index >= self.pageImages.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = CarouselView()
        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    @IBAction func close(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
