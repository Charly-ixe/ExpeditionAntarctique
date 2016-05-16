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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
