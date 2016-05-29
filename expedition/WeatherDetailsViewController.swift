//
//  WeatherDetailsViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 28/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var weatherDetailsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var text = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        weatherDetailsLabel.text = text
        backButton.tintColor = nunatakBlackAlpha
        
    }
    @IBAction func backToWeatherViewController(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
