//
//  FirstUseViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 06/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class FirstUseViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController?
    var pageVideos : Array<String> = ["ecran1", "ecran2", "ecran3", "ecran4"]
    var pageTexts : [String] = ["Bienvenue en Antarctique. Ici se situe la base française Dumont D’Urville.", "Chaque année, des scientifiques viennent y mener leurs recherches.  Voici l’équipe T66.", "Ces hommes sont coupés du monde. Presque à l’état de survie, ils bravent le froid pour accomplir leur mission.", "Ils vont avoir besoin d’aide pour faire face aux défis de la nature."]
    var currentIndex : Int = 0
    var controllers : [VideoViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: VideoViewController = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! VideoViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! VideoViewController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == self.pageVideos.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> VideoViewController? {
        if self.pageVideos.count == 0 || index >= self.pageVideos.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if index >= self.controllers.count {
            self.controllers.append(VideoViewController())
            self.controllers.last?.imageFile = pageVideos[index]
            self.controllers.last?.pageIndex = index
        }
        currentIndex = index
        
        return self.controllers[index]
        
//        let pageContentViewController = VideoViewController()
//        pageContentViewController.imageFile = pageVideos[index]
//        pageContentViewController.pageIndex = index
//        currentIndex = index
//        
//        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageVideos.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
