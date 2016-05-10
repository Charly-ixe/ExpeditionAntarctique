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
    
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    @IBAction func showWeatherTab(sender: UIButton) {
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weatherTab")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.dataTabsContainer)
    }
    
    @IBAction func showMoralTab(sender: UIButton) {
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("moralTab")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.dataTabsContainer)
    }
    
    @IBAction func showStuffTab(sender: UIButton) {
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("stuffTab")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.dataTabsContainer)
    }
    
}