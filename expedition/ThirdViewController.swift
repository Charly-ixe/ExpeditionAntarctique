//
//  ThirdViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 20/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ThirdViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var currentWeatherView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var dataTemperatureLabel: UILabel!
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var dataWindLabel: UILabel!
    @IBOutlet weak var dataWindDirectionLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var dataTabsContainer: UIView!
    @IBOutlet weak var weatherTabButton: UIButton!
    @IBOutlet weak var moralTabButton: UIButton!
    @IBOutlet weak var stuffTabButton: UIButton!
    @IBOutlet weak var selectedTabCursor: UIView!
    @IBOutlet weak var tabCursorLeadingConstraint: NSLayoutConstraint!
    var player: AVPlayer?
    
    
    weak var currentViewController: UIViewController?
    var isSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var cursorRect = self.selectedTabCursor.frame
//        cursorRect.size.width = self.view.bounds.size.width / 3.0
//        self.selectedTabCursor.frame = cursorRect
        
        // Customize the currentWeatherView
        
        currentWeatherView.layer.shadowColor = brashWhite.CGColor
        currentWeatherView.layer.shadowOffset = CGSizeZero
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: currentWeatherImageView.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.BottomLeft), cornerRadii: CGSizeMake(6, 6)).CGPath
        currentWeatherImageView.layer.mask = maskLayer
        
        temperatureLabel.textColor = nunatakBlackAlpha
        windLabel.textColor = nunatakBlackAlpha
        windDirectionLabel.textColor = nunatakBlackAlpha
        dataTemperatureLabel.textColor = nunatakBlack
        celciusLabel.textColor = nunatakBlack
        dataWindLabel.textColor = nunatakBlack
        dataWindDirectionLabel.textColor = nunatakBlack
        
        // Customize the tabs
        
        weatherTabButton.tintColor = nunatakBlack
        moralTabButton.tintColor = nunatakBlack
        stuffTabButton.tintColor = nunatakBlack
        
        
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weatherTab")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.dataTabsContainer)
        weatherTabButton.selected = true
        
    }
        
//        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("tempete", withExtension: "mp4")!
//        
//        player = AVPlayer(URL: videoURL)
        
        override func viewDidAppear(animated: Bool) {
            if ModelController.Model.currentSituation!.id == "f975cfdc-661c-4ec4-a095-cd08115fcc30" {
                let videoURL: NSURL = NSBundle.mainBundle().URLForResource("tempete", withExtension: "mp4")!
                player = AVPlayer(URL: videoURL)
            }
            if ModelController.Model.currentSituation!.id == "409c2854-7048-47b7-bb53-f034b5590697" {
                let videoURL: NSURL = NSBundle.mainBundle().URLForResource("calme", withExtension: "mp4")!
                player = AVPlayer(URL: videoURL)
            }
            if ModelController.Model.currentSituation!.id == "8c5e5112-afe6-4ecf-a2ff-e371ab4ccec7" {
                let videoURL: NSURL = NSBundle.mainBundle().URLForResource("ensoleille", withExtension: "mp4")!
                player = AVPlayer(URL: videoURL)
            }
        
            player?.actionAtItemEnd = .None
            player?.muted = true
        
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            //        playerLayer.zPosition = -1
        
            playerLayer.frame = CGRectMake(0, 0, currentWeatherView.frame.width / 2, currentWeatherImageView.frame.height)
        
            currentWeatherImageView.layer.addSublayer(playerLayer)
            player?.play()
        
            NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.loopVideo),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: player?.currentItem)
        
        }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Functions for tabs container
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMoveToParentViewController(nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.dataTabsContainer!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animateWithDuration(0.3, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMoveToParentViewController(self)
        })
    }
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    
//    func getContainer() -> UIView {
//        let container = self.container
//        return container!
//    }
    
    // Actions
    
    @IBAction func showTabContent(sender: UIButton) {
        let index = sender.tag - 100
        
        let currentIndex = self.selectedTabCursor.tag
        if currentIndex != index {
            self.selectedTabCursor.tag = index
            
            UIView.animateWithDuration(0.3, animations: {
                self.tabCursorLeadingConstraint.constant = (CGFloat(index) * self.selectedTabCursor.frame.width) - 18
                self.view.layoutIfNeeded()
//                var cursorRect = self.selectedTabCursor.frame
//                cursorRect.origin.x = CGFloat(index) * cursorRect.size.width
//                self.selectedTabCursor.frame = cursorRect
            })
            
            if sender.restorationIdentifier == "weatherTabButton" {
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weatherTab")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                //            sender.selected = true
                
                
            }
            else if sender.restorationIdentifier == "moralTabButton" {
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("moralTab")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                //            sender.selected = true
            }
            else if sender.restorationIdentifier == "stuffTabButton" {
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("stuffTab")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                //            sender.selected = true
            }

        }
        
        
        
    }
    
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRectMake(0, size.height - lineWidth, size.width, lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}