//
//  WeatherTabViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 12/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class WeatherTabViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var windView: UIView!
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        temperatureView.layer.shadowColor = brashWhite.CGColor
        temperatureView.layer.shadowOffset = CGSizeZero
        windView.layer.shadowColor = brashWhite.CGColor
        windView.layer.shadowOffset = CGSizeZero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
