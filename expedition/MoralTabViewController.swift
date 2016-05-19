//
//  MoralTabViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 12/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class MoralTabViewController: UIViewController {
    
    @IBOutlet weak var centerProfilePictureImageView: UIImageView!
    @IBOutlet weak var leftProfilePictureImageView: UIImageView!
    @IBOutlet weak var rightProfilePictureImageView: UIImageView!
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var droughtLabel: UILabel!
    @IBOutlet weak var moralLabel: UILabel!
    @IBOutlet weak var teamSpiritLabel: UILabel!
    @IBOutlet weak var hungerGauge: DrawGauge!
    @IBOutlet weak var droughtGauge: DrawGauge!
    @IBOutlet weak var moralGauge: DrawGauge!
    @IBOutlet weak var teamSpiritGauge: DrawGauge!
    
    var isSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hungerGauge.gaugeValue = 80.0
        droughtGauge.gaugeValue = 10.0
        moralGauge.gaugeValue = 50.0
        teamSpiritGauge.gaugeValue = 100.0
        
        centerProfilePictureImageView.layer.cornerRadius = centerProfilePictureImageView.frame.size.width / 2
        centerProfilePictureImageView.clipsToBounds = true
        centerProfilePictureImageView.layer.borderWidth = 4.0
        centerProfilePictureImageView.layer.borderColor = nunatakBlack.CGColor
        leftProfilePictureImageView.layer.cornerRadius = leftProfilePictureImageView.frame.size.width / 2
        leftProfilePictureImageView.clipsToBounds = true
        leftProfilePictureImageView.layer.borderWidth = 2.0
        leftProfilePictureImageView.layer.borderColor = nunatakBlack.CGColor
        rightProfilePictureImageView.layer.cornerRadius = rightProfilePictureImageView.frame.size.width / 2
        rightProfilePictureImageView.clipsToBounds = true
        rightProfilePictureImageView.layer.borderWidth = 2.0
        rightProfilePictureImageView.layer.borderColor = nunatakBlack.CGColor
        
        hungerLabel.textColor = nunatakBlackAlpha
        droughtLabel.textColor = nunatakBlackAlpha
        moralLabel.textColor = nunatakBlackAlpha
        teamSpiritLabel.textColor = nunatakBlackAlpha
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
