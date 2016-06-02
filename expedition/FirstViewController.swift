//
//  FirstViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 20/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleViewBottomConstraint: NSLayoutConstraint!
    var imageView : UIImageView!
    var mapElements : [MapElementUIView] = []
    var isOpen : Bool = false
    let transition = PopAnimator()
    var container : UIView?
    @IBOutlet var titleViewTapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "terre-danger2.png"))
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        scrollView.contentOffset = imageView.center
        scrollView.minimumZoomScale = 0.3
        scrollView.maximumZoomScale = 1
        scrollView.userInteractionEnabled = true
        scrollView.exclusiveTouch = true
        
        let elt = MapElementUIView(frame: CGRectMake(1240, 695, 120, 120), name: "Dumont", eltDescription: "Base Française", img: "base-off")
        mapElements.append(elt)
        let elt2 = MapElementUIView(frame: CGRectMake(761, 803, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house-off")
        mapElements.append(elt2)
        let elt3 = MapElementUIView(frame: CGRectMake(986, 1011, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house-off")
        mapElements.append(elt3)
        let elt4 = MapElementUIView(frame: CGRectMake(1233, 1011, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier-off")
        mapElements.append(elt4)
        let elt5 = MapElementUIView(frame: CGRectMake(841, 1099, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier-off")
        mapElements.append(elt5)
        let elt6 = MapElementUIView(frame: CGRectMake(228, 659, 120, 120), name: "Base", eltDescription: "Une base", img: "base-off")
        mapElements.append(elt6)
        let elt7 = MapElementUIView(frame: CGRectMake(662, 1167, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house-off")
        mapElements.append(elt7)
        let elt8 = MapElementUIView(frame: CGRectMake(520, 1215, 120, 120), name: "Base", eltDescription: "Une base", img: "base-off")
        mapElements.append(elt8)
        let elt9 = MapElementUIView(frame: CGRectMake(1564, 804, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house-off")
        mapElements.append(elt9)
        let elt10 = MapElementUIView(frame: CGRectMake(1588, 1167, 120, 120), name: "Base", eltDescription: "Une base", img: "base-off")
        mapElements.append(elt10)
        let elt11 = MapElementUIView(frame: CGRectMake(1564, 1339, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house-off")
        mapElements.append(elt11)
        let elt12 = MapElementUIView(frame: CGRectMake(1750, 1449, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier-off")
        mapElements.append(elt12)
        let elt13 = MapElementUIView(frame: CGRectMake(1636, 1497, 120, 120), name: "Base", eltDescription: "Une base", img: "base-off")
        mapElements.append(elt13)
        let elt14 = MapElementUIView(frame: CGRectMake(1453, 1734, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier-off")
        mapElements.append(elt14)
        let elt15 = MapElementUIView(frame: CGRectMake(938, 2000, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier-off")
        mapElements.append(elt15)
        let elt16 = MapElementUIView(frame: CGRectMake(1540, 1830, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house-off")
        mapElements.append(elt16)
        let elt17 = MapElementUIView(frame: CGRectMake(402, 2176, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier-off")
        mapElements.append(elt17)
        
        
        for elt in mapElements {
            imageView.addSubview(elt)
        }
        
//        var titleView = UIView()
//        self.view.addSubview(titleView)
//        
//        var constraints : [NSLayoutConstraint] = []
//        var bottomConstraint = NSLayoutConstraint(item: titleView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
//        constraints.append(bottomConstraint)
//        var leftConstraint = NSLayoutConstraint(item: titleView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 12)
//        constraints.append(leftConstraint)
//        var rightConstraint = NSLayoutConstraint(item: titleView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 12)
//        constraints.append(rightConstraint)
//        self.view.addConstraints(constraints)
//        titleView.bounds.size.height = 110
//        titleView.backgroundColor = nunatakBlack
        
        titleView.layer.shadowColor = brashWhite.CGColor
        titleView.layer.shadowOffset = CGSizeZero
        
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if isOpen == false {
            UIView.animateWithDuration(0.3, animations: {
                self.titleViewBottomConstraint.constant += 120
                self.view.layoutIfNeeded()
                self.isOpen = true
            })
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isOpen == true {
            UIView.animateWithDuration(0.3, animations: {
                self.titleViewBottomConstraint.constant -= 120
                self.view.layoutIfNeeded()
                self.isOpen = false
            })
        }
    }
    
    
    @IBAction func tapElement(sender: UIButton!) {
        print("tap this shiiiiiiiiiit will I tap or not fuck this motherfucking shit")
    }
    
    @IBAction func tappedTitleView(sender: UITapGestureRecognizer) {
        print("Tap !!")
        let placeDetails = storyboard?.instantiateViewControllerWithIdentifier("PlaceViewController") as! PlaceViewController
        placeDetails.transitioningDelegate = self
        presentViewController(placeDetails, animated: true, completion: nil)
    }

}

extension FirstViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
                             sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            transition.originFrame = titleView!.superview!.convertRect(titleView!.frame, toView: nil)
            transition.presenting = true
            return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
