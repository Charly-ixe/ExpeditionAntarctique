//
//  FirstViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 20/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class FirstViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleViewBottomConstraint: NSLayoutConstraint!
    var imageView : UIImageView!
    var mapElements : [MapElementUIView] = []
    var isOpen : Bool = false
    let transition = PopAnimator()
    var container : UIView?
    @IBOutlet var titleViewTapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var currentMoveView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var childs : [UIView] = []
    
    @IBOutlet var mapTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var showMovementView: UIView!
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedDataLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var directionDataLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationDataLabel: UILabel!
    var player: AVPlayer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "terre-danger2.png"))
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        scrollView.contentOffset = imageView.center
        scrollView.minimumZoomScale = 0.3
        scrollView.maximumZoomScale = 1
        scrollView.userInteractionEnabled = true
//        scrollView.exclusiveTouch = true
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapElement(_:)))
        tapGesture.delegate = self
        
        
        for element in mapElements {
            imageView.addSubview(element)
            element.btn!.addGestureRecognizer(tapGesture)
            element.userInteractionEnabled = true
            scrollView.bringSubviewToFront(element)
        }
        
        currentMoveView.layer.shadowColor = brashWhite.CGColor
        currentMoveView.layer.shadowOffset = CGSizeZero
        
        speedLabel.textColor = nunatakBlackAlpha
        speedDataLabel.textColor = nunatakBlack
        kmLabel.textColor = nunatakBlack
        directionLabel.textColor = nunatakBlackAlpha
        directionDataLabel.textColor = nunatakBlack
        destinationLabel.textColor = nunatakBlackAlpha
        destinationDataLabel.textColor = nunatakBlack
        
//        currentMoveView.clipsToBounds = true
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: showMovementView.bounds, byRoundingCorners: UIRectCorner.TopRight.union(.BottomRight), cornerRadii: CGSizeMake(6, 6)).CGPath
        showMovementView.layer.mask = maskLayer
        
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("lent", withExtension: "mp4")!
        
        player = AVPlayer(URL: videoURL)
        player?.actionAtItemEnd = .None
        player?.muted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResize
//        playerLayer.zPosition = -1
        
        playerLayer.frame = CGRectMake(0, 0, showMovementView.frame.width, showMovementView.frame.height)
        
        showMovementView.layer.addSublayer(playerLayer)
        player?.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.loopVideo),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: player?.currentItem)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.loopVideo),
                                                         name: UIApplicationDidBecomeActiveNotification,
                                                         object: player?.currentItem)
        
        titleView.layer.shadowColor = brashWhite.CGColor
        titleView.layer.shadowOffset = CGSizeZero
        
        typeLabel.text = "BASE"
        typeLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        typeLabel.textColor = nunatakBlackAlpha
        
        titleLabel.text = "Dumont d'Urville"
        titleLabel.font = UIFont(name: "AvenirNext-Regular", size: 32)
        titleLabel.textColor = nunatakBlack
        
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
//        if isOpen == true {
//            UIView.animateWithDuration(0.3, animations: {
//                self.titleViewBottomConstraint.constant -= 120
//                self.view.layoutIfNeeded()
//                self.isOpen = false
//            })
//        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func tapElement(sender: UITapGestureRecognizer? = nil) {
        print(sender?.view)
    }
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    
    
    @IBAction func tappedElt(sender: UITapGestureRecognizer) {
        print("Tapping shit")
    }
    
    @IBAction func tappedTitleView(sender: UITapGestureRecognizer) {
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
