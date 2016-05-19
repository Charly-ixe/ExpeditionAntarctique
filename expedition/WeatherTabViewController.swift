//
//  WeatherTabViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 12/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class WeatherTabViewController: UIViewController {
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var pressureView: UIView!
    @IBOutlet weak var humidityView: UIView!
    @IBOutlet var temperatureTapGesture: UITapGestureRecognizer!
    @IBOutlet var windTapGesture: UITapGestureRecognizer!
    @IBOutlet var pressureTapGesture: UITapGestureRecognizer!
    @IBOutlet var humidityTapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Custom the uiviews
        
        temperatureView.layer.shadowColor = brashWhite.CGColor
        temperatureView.layer.shadowOffset = CGSizeZero
        windView.layer.shadowColor = brashWhite.CGColor
        windView.layer.shadowOffset = CGSizeZero
        pressureView.layer.shadowColor = brashWhite.CGColor
        pressureView.layer.shadowOffset = CGSizeZero
        humidityView.layer.shadowColor = brashWhite.CGColor
        humidityView.layer.shadowOffset = CGSizeZero
        
        // Tap Gestures
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showTappedView(sender: UITapGestureRecognizer){
        let constraint = NSLayoutConstraint(item: sender.view!, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -12)
        constraint.active = true
        sender.view?.updateConstraints()
        self.view.layoutIfNeeded()
        
    }
    

}
