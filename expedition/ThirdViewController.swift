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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customize the currentWeatherView
        
        currentWeatherView.layer.cornerRadius = 6.0
        currentWeatherView.layer.shadowColor = brashWhite.CGColor
        currentWeatherView.layer.shadowOpacity = 0.2
        currentWeatherView.layer.shadowOffset = CGSizeZero
        currentWeatherView.layer.shadowRadius = 6.0
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}