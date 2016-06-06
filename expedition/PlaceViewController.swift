//
//  PlaceViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 02/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var pageViewController : UIPageViewController?
    var pageImages : Array<String> = ["photo_avant_poste.jpg", "photo_zodiac.jpg", "photo_pingouin.jpg"]
    var currentIndex : Int = 0
    var titleView : UIView?
    var typeLabel : UILabel?
    var titleLabel : UILabel = UILabel()
    var descriptionTextView : UITextView = UITextView()
    var descriptionLabel : UILabel?
    var distanceLabel : UILabel?
    var distanceDataLabel : UILabel?
    var inhabitantsLabel : UILabel?
    var inhabitantsDataLabel : UILabel?
    var firstStuffView : UIView?
    var secondStuffView : UIView?
    var thirdStuffView : UIView?
    var scrollViewDescription : UIScrollView?
    var scrollViewDescriptionConstraints : [NSLayoutConstraint] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 790)
        print(self.view.frame.width)
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: CarouselView = viewControllerAtIndex(0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(4, 150, self.view.frame.width, 300);
        let newFrameCarousel = CGRectMake(4, 0, self.view.frame.size.width, 300)
        pageViewController!.view.alpha = 0
        
        addChildViewController(pageViewController!)
        scrollView.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        scrollViewDescription = UIScrollView()
//        scrollViewDescription!.backgroundColor = nunatakBlack
        
        scrollViewDescription!.frame = CGRectMake(0, pageViewController!.view.frame.height, scrollView.frame.width, 500)
        
        
        scrollView.addSubview(scrollViewDescription!)
        
        distanceLabel = UILabel()
        distanceLabel!.frame = CGRectMake(24, 80, 80, 14)
        distanceLabel!.text = "DISTANCE"
        distanceLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        distanceLabel!.textColor = nunatakBlackAlpha
        scrollViewDescription?.addSubview(distanceLabel!)
        
        distanceDataLabel = UILabel()
        distanceDataLabel!.frame = CGRectMake(24, 100, 80, 18)
        distanceDataLabel!.text = "À 23KM"
        distanceDataLabel!.font = UIFont(name: "AvenirNext-Medium", size: 16)
        distanceDataLabel!.textColor = nunatakBlack
        scrollViewDescription?.addSubview(distanceDataLabel!)
        
        inhabitantsLabel = UILabel()
        inhabitantsLabel!.frame = CGRectMake(self.view.frame.width / 2, 80, 80, 14)
        inhabitantsLabel!.text = "HIVERNANTS"
        inhabitantsLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        inhabitantsLabel!.textColor = nunatakBlackAlpha
        scrollViewDescription?.addSubview(inhabitantsLabel!)
        
        inhabitantsDataLabel = UILabel()
        inhabitantsDataLabel!.frame = CGRectMake(self.view.frame.width / 2, 100, 80, 18)
        inhabitantsDataLabel!.text = "62"
        inhabitantsDataLabel!.font = UIFont(name: "AvenirNext-Medium", size: 16)
        inhabitantsDataLabel!.textColor = nunatakBlack
        scrollViewDescription?.addSubview(inhabitantsDataLabel!)
        
        descriptionLabel = UILabel()
        descriptionLabel!.frame = CGRectMake(24, 160, 80, 14)
        descriptionLabel!.text = "DESCRIPTION"
        descriptionLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        descriptionLabel!.textColor = nunatakBlackAlpha
        scrollViewDescription?.addSubview(descriptionLabel!)
        
        descriptionTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris finibus condimentum semper. Cras elementum hendrerit viverra. Nulla sed lacus quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas sit amet elit sapien. Maecenas mauris lacus, commodo quis est eget, euismod elementum leo. Quisque consequat dignissim dui sit amet tincidunt. Duis eget magna consectetur, molestie mauris quis, sodales nulla. Duis sit amet lectus nunc. Maecenas pulvinar lacus ut nibh cursus, at tempus est rhoncus. Praesent vehicula molestie velit ut mattis. Maecenas tristique interdum justo. Nullam auctor elit eu elit posuere efficitur. Sed at volutpat massa. Fusce tincidunt pharetra ullamcorper. Nulla a ipsum lectus."
        
        descriptionTextView.font = UIFont(name: "AvenirNext-Medium", size: 16)
        descriptionTextView.textColor = nunatakBlack
        descriptionTextView.frame = CGRectMake(24, 180, self.view.frame.width - 40, 500)
        descriptionTextView.alpha = 0
        scrollViewDescription!.addSubview(descriptionTextView)
        
        let footer = DrawFooter()
        footer.frame = CGRectMake(0, 640, self.view.frame.width + 4, 300)
        footer.backgroundColor = UIColor.whiteColor()
        scrollViewDescription?.addSubview(footer)
        
        let footerLabel = UILabel()
        footer.addSubview(footerLabel)
        footerLabel.frame = CGRectMake(0, 100, footer.frame.width, 30)
        footerLabel.text = "Réserves"
        footerLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        footerLabel.textColor = UIColor.whiteColor()
        footerLabel.textAlignment = .Center
        
        firstStuffView = UIView()
        firstStuffView!.frame = CGRectMake((footer.frame.width / 4) - 32, 170, 64, 64)
        firstStuffView!.layer.cornerRadius = firstStuffView!.frame.size.width / 2
        firstStuffView!.backgroundColor = UIColor.whiteColor()
        var firstStuffImageView = UIImageView(image: UIImage(named: "Fuel"))
//        firstStuffImageView.frame = firstStuffView!.frame
        firstStuffView!.addSubview(firstStuffImageView)
        
        secondStuffView = UIView()
        secondStuffView!.frame = CGRectMake((footer.frame.width / 2) - 32, 170, 64, 64)
        secondStuffView!.layer.cornerRadius = secondStuffView!.frame.size.width / 2
        secondStuffView!.backgroundColor = nunatakBlack
        thirdStuffView = UIView()
        thirdStuffView!.frame = CGRectMake(((footer.frame.width / 4) * 3) - 32, 170, 64, 64)
        thirdStuffView!.layer.cornerRadius = thirdStuffView!.frame.size.width / 2
        thirdStuffView!.backgroundColor = nunatakBlack
        
        footer.addSubview(firstStuffView!)
        footer.addSubview(secondStuffView!)
        footer.addSubview(thirdStuffView!)
        

        scrollViewDescription!.contentSize = CGSize(width: self.view.frame.width, height: 640 + footer.frame.height)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        titleView = UIVisualEffectView(effect: blurEffect)
        titleView!.frame = CGRectMake(16, pageViewController!.view.frame.height, self.view.frame.width - 24, 120)
        let newFrame =  CGRectMake(15, pageViewController!.view.frame.height - 70, self.view.frame.width - 24, 120)
        titleView!.alpha = 0
        titleView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.scrollView.addSubview(titleView!)
        
        typeLabel = UILabel()
        titleView!.addSubview(typeLabel!)
        typeLabel!.frame = CGRectMake(0, 20, titleView!.bounds.width, 14)
        typeLabel!.text = "BASE"
        typeLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        typeLabel!.textColor = nunatakBlackAlpha
        typeLabel!.textAlignment = .Center
        
        
        titleLabel.frame = CGRectMake(0, 45, titleView!.frame.width, 34)
        titleLabel.text = "Dumont d'Urville"
        titleLabel.font = UIFont(name: "AvenirNext-Regular", size: 32)
        titleLabel.textColor = nunatakBlack
        titleLabel.textAlignment = .Center
        titleView!.addSubview(titleLabel)
        
        UIView.animateWithDuration(0.3, delay: 0.2, options: [], animations: {
            self.pageViewController!.view.frame = newFrameCarousel
            self.pageViewController!.view.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0.30, options: [], animations: {
            self.titleView!.frame = newFrame
            self.titleView!.alpha = 1
            self.descriptionTextView.alpha = 1
            }, completion: nil)
        
        self.view.bringSubviewToFront(closeButton)
        

    }
    
    override func viewDidAppear(animated: Bool) {
        titleView!.clipsToBounds = false
        titleView!.layer.masksToBounds = false
        self.titleView!.layer.shadowOpacity = 0.2
        self.titleView!.layer.shadowColor = brashWhite.CGColor
        self.titleView!.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.titleView!.layer.shadowRadius = 10
        
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    
    
    @IBAction func close(sender: UIButton) {
        UIView.animateWithDuration(0.3, animations: {
            self.view.alpha = 0
        })
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension NSLayoutConstraint {
    
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
