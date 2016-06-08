//
//  CharacterChoiceViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 07/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class CharacterChoiceViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController?
    var pageImages : Array<String> = ["choix1.png", "choix2.png", "choix3.png"]
    var currentIndex : Int = 0
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: CharacterViewController = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = nunatakBlackAlpha
        pageControl.currentPageIndicatorTintColor = nunatakBlack
        pageControl.backgroundColor = backgroundDotsColor2
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CharacterViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CharacterViewController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == self.pageImages.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> CharacterViewController? {
        if self.pageImages.count == 0 || index >= self.pageImages.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        
        
        let pageContentViewController = CharacterViewController()
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

    
    @IBAction func chooseCharacter(sender: UITapGestureRecognizer) {
        let newStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController? = newStoryboard.instantiateViewControllerWithIdentifier("tab")
        self.showViewController(vc!, sender: self)
    }
}
