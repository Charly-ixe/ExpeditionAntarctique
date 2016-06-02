//
//  PlaceViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 02/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func close(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
