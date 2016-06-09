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

    @IBOutlet weak var scrollView: PassTouchesScrollView!
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
    
    
    @IBOutlet weak var showMovementView: UIView!
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedDataLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var directionDataLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationDataLabel: UILabel!
    var player: AVPlayer?
    var currentElement : MapElementUIView!
    var character : MapElementUIView!
    var haloObj : UIImageView?
    @IBOutlet var tapMapGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "terre-danger2.png"))
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.minimumZoomScale = 0.3
        scrollView.maximumZoomScale = 0.8
        
        scrollView.userInteractionEnabled = true
        
        scrollView.delegate = self
//        scrollView.delegatePass = imageView
//        scrollView.delaysContentTouches = false
//        imageView.userInteractionEnabled = true
        
        let elt = MapElementUIView(frame: CGRectMake(938, 659, 120, 120), name: "Dumont d'Urville", eltDescription: "Entre nous, on l’appelle notre Havre de Paix. Ici, on est toujours en sécurité, tous les scientifiques français hivernent dans cette base. Et autant te dire qu’à Noël, il y a une sacré ambiance !", img: "base", type: "Base")
        mapElements.append(elt)
        let elt2 = MapElementUIView(frame: CGRectMake(761, 803, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house", type: "Avant-Poste")
        mapElements.append(elt2)
        let elt3 = MapElementUIView(frame: CGRectMake(986, 1011, 120, 120), name: "Mc Murdo", eltDescription: "Station située sur la dépendance de Ross, territoire revendiqué par la Nouvelle-Zélande. Construite en 1956, s'appelait initialement Naval Air Facility McMurdo, du nom d'Archibald McMurdo dont le site fut découvert par l'explorateur anglais Robert Falcon Scott.", img: "house", type: "Avant-Poste")
        mapElements.append(elt3)
        let elt4 = MapElementUIView(frame: CGRectMake(1233, 1011, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier", type: "Glacier")
        mapElements.append(elt4)
        let elt5 = MapElementUIView(frame: CGRectMake(841, 1099, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier", type: "Glacier")
        mapElements.append(elt5)
        let elt6 = MapElementUIView(frame: CGRectMake(228, 659, 120, 120), name: "Base", eltDescription: "Une base", img: "base", type: "Base")
        mapElements.append(elt6)
        let elt7 = MapElementUIView(frame: CGRectMake(662, 1167, 120, 120), name: "Charcot", eltDescription: "Ancienne base scientifique française portant le nom du commandant explorateur Jean-Baptiste Charcot. Elle est désafectée destinée à l'étude de la glaciologie depuis 1959. Un corps principal de 24 m2  est constitué de sections demi-cylindriques de tôles assemblées bout à bout. Cette forme est prévue pour résister au mieux à la pression de neige accumulée dessus.", img: "house", type: "Avant-Poste")
        mapElements.append(elt7)
        let elt8 = MapElementUIView(frame: CGRectMake(520, 1215, 120, 120), name: "Concordia", eltDescription: "Station de recherche franco-italienne permanente installée au Dôme C, sur le Plateau Antarctique. Concordia est une des trois stations à l'intérieur du continent Antarctique à fonctionner toute l'année. Y est étudié astronomie, glaciologie, et chimie de l’atmosphère. Elle peut accueillir une quinzaine de personnes, contre une soixantaine l'été.", img: "base", type: "Base")
        mapElements.append(elt8)
        let elt9 = MapElementUIView(frame: CGRectMake(1564, 804, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house", type: "Avant-Poste")
        mapElements.append(elt9)
        let elt10 = MapElementUIView(frame: CGRectMake(1588, 1167, 120, 120), name: "Base", eltDescription: "Une base", img: "base", type: "Base")
        mapElements.append(elt10)
        let elt11 = MapElementUIView(frame: CGRectMake(1564, 1339, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house", type: "Avant-Poste")
        mapElements.append(elt11)
        let elt12 = MapElementUIView(frame: CGRectMake(1750, 1449, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier", type: "Glacier")
        mapElements.append(elt12)
        let elt13 = MapElementUIView(frame: CGRectMake(1636, 1497, 120, 120), name: "Base", eltDescription: "Une base", img: "base", type: "Base")
        mapElements.append(elt13)
        let elt14 = MapElementUIView(frame: CGRectMake(1453, 1734, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier", type: "Glacier")
        mapElements.append(elt14)
        let elt15 = MapElementUIView(frame: CGRectMake(938, 2000, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier", type: "Glacier")
        mapElements.append(elt15)
        let elt16 = MapElementUIView(frame: CGRectMake(1540, 1830, 120, 120), name: "Avant-poste", eltDescription: "Un avant-poste", img: "house", type: "Avant-Poste")
        mapElements.append(elt16)
        let elt17 = MapElementUIView(frame: CGRectMake(402, 2176, 120, 120), name: "Glacier", eltDescription: "Un glacier", img: "glacier", type: "Glacier")
        mapElements.append(elt17)
        
        character = MapElementUIView(frame: CGRectMake(1184, 793, 120, 120), name: "Guillaume", eltDescription: "Guillaume", img: "Smile", type: "Character")
        
        haloObj = UIImageView()
        haloObj!.image = UIImage.gifWithName("localisation")
        imageView.addSubview(haloObj!)
        
        
        for element in mapElements {
            imageView.addSubview(element)
            element.userInteractionEnabled = true
            scrollView.bringSubviewToFront(element)
        }
        
        imageView.addSubview(character)
//        scrollView.contentOffset = CGPoint(x: (character.frame.origin.x - (self.view.frame.width / 2)) + character.frame.width / 2, y: (character.frame.origin.y - (self.view.frame.height / 2)) + character.frame.height / 2)
        
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
    
    override func viewWillAppear(animated: Bool) {
        if ModelController.Model.currentSituation!.id == "f975cfdc-661c-4ec4-a095-cd08115fcc30" {
            character.frame = CGRectMake(1184, 793, 120, 120)
            
        }
        if ModelController.Model.currentSituation!.id == "409c2854-7048-47b7-bb53-f034b5590697" {
            character.frame = CGRectMake(965, 687, 120, 120)
            haloObj!.frame = CGRectMake(800, 1260, 120, 120)
        }
        if ModelController.Model.currentSituation!.id == "8c5e5112-afe6-4ecf-a2ff-e371ab4ccec7" {
            character.frame = CGRectMake(965, 1025, 120, 120)
        }
        scrollView.setZoomScale(0.8, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollView.contentOffset = CGPoint(x: character.frame.origin.x - self.view.frame.width, y: character.frame.origin.y - (self.view.frame.height / 2 + 100))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isOpen == true {
            UIView.animateWithDuration(0.3, animations: {
                self.titleViewBottomConstraint.constant -= 120
                self.view.layoutIfNeeded()
                self.isOpen = false
//                self.currentElement.transform = CGAffineTransformMakeScale(1, 1)
            })
        }
    }

    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    @IBAction func tappedMap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(imageView)
        for element in mapElements {
            if CGRectContainsPoint(element.frame, point) {
                currentElement = element
                if isOpen == false {
                    UIView.animateWithDuration(0.3, animations: {
                        self.titleViewBottomConstraint.constant += 120
                        self.view.layoutIfNeeded()
//                        self.currentElement.transform = CGAffineTransformMakeScale(2, 2)
                        self.isOpen = true
                    })
                }
                titleLabel.text = element.name
                typeLabel.text = element.type
            }
        }
        
    }
    
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    
    
    @IBAction func tappedTitleView(sender: UITapGestureRecognizer) {
        let placeDetails = storyboard?.instantiateViewControllerWithIdentifier("PlaceViewController") as! PlaceViewController
        placeDetails.transitioningDelegate = self
        placeDetails.titleLabel.text = currentElement.name
        placeDetails.typeLabel.text = currentElement.type
        placeDetails.descriptionTextView.text = currentElement.elementDescription
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
