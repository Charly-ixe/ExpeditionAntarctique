//
//  WeatherTabViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 12/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

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
    var player: AVPlayer?
    
    @IBOutlet weak var tempGraphImageView: UIImageView!
    
    @IBOutlet weak var windGraphImageView: UIImageView!
    @IBOutlet weak var pressureGraphImageView: UIImageView!
    @IBOutlet weak var humidityGraphImageView: UIImageView!
    
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
        
        tempGraphImageView.contentMode = UIViewContentMode.ScaleAspectFill
        tempGraphImageView.clipsToBounds = true
        windGraphImageView.contentMode = UIViewContentMode.ScaleAspectFill
        windGraphImageView.clipsToBounds = true
        pressureGraphImageView.contentMode = UIViewContentMode.ScaleAspectFill
        pressureGraphImageView.clipsToBounds = true
        humidityGraphImageView.contentMode = UIViewContentMode.ScaleAspectFill
        humidityGraphImageView.clipsToBounds = true
        
//        let graphTemp = UIImageView(frame: temperatureView.frame)
//        graphTemp.image = UIImage(named: "stat-2")
//        temperatureView.addSubview(graphTemp)
        
        // Tap Gestures
//        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("Temperature", withExtension: "mp4")!
//        
//        player = AVPlayer(URL: videoURL)
//        player?.actionAtItemEnd = .None
//        player?.muted = true
//        
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
//        //        playerLayer.zPosition = -1
//        
//        playerLayer.frame = CGRectMake(-100, 0, temperatureView.frame.width, temperatureView.frame.height)
//        
//        temperatureView.layer.addSublayer(playerLayer)
//        player?.play()
        
        print(temperatureView.frame)
        print(pressureView.frame)
        print(windView.frame)
        print(humidityView.frame)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if ModelController.Model.currentSituation!.id == "f975cfdc-661c-4ec4-a095-cd08115fcc30" {
            tempGraphImageView.image = UIImage(named: "temp-tempete")
            windGraphImageView.image = UIImage(named: "wind-tempete")
            pressureGraphImageView.image = UIImage(named: "pressure-tempete")
            humidityGraphImageView.image = UIImage(named: "hum-tempete")
        }
        if ModelController.Model.currentSituation!.id == "409c2854-7048-47b7-bb53-f034b5590697" {
            tempGraphImageView.image = UIImage(named: "temp-moyen")
            windGraphImageView.image = UIImage(named: "wind-moyen")
            pressureGraphImageView.image = UIImage(named: "pressure-moyen")
            humidityGraphImageView.image = UIImage(named: "hum-moyen")
            
        }
        if ModelController.Model.currentSituation!.id == "8c5e5112-afe6-4ecf-a2ff-e371ab4ccec7" {
            tempGraphImageView.image = UIImage(named: "temp-calme")
            windGraphImageView.image = UIImage(named: "wind-calme")
            pressureGraphImageView.image = UIImage(named: "pressure-calme")
            humidityGraphImageView.image = UIImage(named: "hum-calme")
        }
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
