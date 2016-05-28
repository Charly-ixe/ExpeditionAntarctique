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
    var text = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        weatherDetailsLabel.text = text
    }
}
