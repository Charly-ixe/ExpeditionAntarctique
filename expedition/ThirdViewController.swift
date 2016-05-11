//
//  ThirdViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 20/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
let brashWhite = UIColor(red:36/255, green:90/255, blue:185/255, alpha:1.0)
let nunatakBlack = UIColor(red:10/255, green:35/255, blue:80/255, alpha:1.0)
let nunatakBlackAlpha = UIColor(red:10/255, green:35/255, blue:80/255, alpha:0.2)


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
    
    weak var currentViewController: UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customize the currentWeatherView
        
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
        
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weatherTab")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.dataTabsContainer)
        
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
        UIView.animateWithDuration(0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMoveToParentViewController(self)
        })
    }
    
    @IBAction func showTabContent(sender: UIButton) {
        if sender.restorationIdentifier == "weatherTabButton" {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weatherTab")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }
        else if sender.restorationIdentifier == "moralTabButton" {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("moralTab")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }
        else if sender.restorationIdentifier == "stuffTabButton" {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("stuffTab")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }
    }
    
}