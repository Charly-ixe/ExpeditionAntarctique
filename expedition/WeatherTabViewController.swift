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
    let transition = PopAnimator()
    var selectedView : UIView?
    var container : UIView?
    
    
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
        
        selectedView = sender.view
        let name = selectedView?.restorationIdentifier
        let weatherDetails = storyboard?.instantiateViewControllerWithIdentifier("WeatherDetailsViewController") as! WeatherDetailsViewController
        weatherDetails.transitioningDelegate = self
        print(name)
        weatherDetails.text = name!
        presentViewController(weatherDetails, animated: true, completion: nil)
        
    }
    

}

extension WeatherTabViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
                             sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            transition.originFrame = selectedView!.superview!.convertRect(selectedView!.frame, toView: nil)
            transition.presenting = true
            return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
