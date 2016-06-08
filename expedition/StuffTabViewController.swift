//
//  StuffTabViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 12/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class StuffTabViewController: UIViewController {
    
    @IBOutlet weak var stuffToResupplyView: UIView!
    @IBOutlet weak var stuffBottomLeftView: UIView!
    @IBOutlet weak var stuffBottomRightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize Views
        
//        stuffToResupplyView.layer.shadowColor = brashWhite.CGColor
//        stuffToResupplyView.layer.shadowOffset = CGSizeZero
//        stuffBottomLeftView.layer.shadowColor = brashWhite.CGColor
//        stuffBottomLeftView.layer.shadowOffset = CGSizeZero
//        stuffBottomRightView.layer.shadowColor = brashWhite.CGColor
//        stuffBottomRightView.layer.shadowOffset = CGSizeZero
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
