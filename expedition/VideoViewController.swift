//
//  VideoViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 06/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {

    var pageIndex : Int = 0
    var titleText : String = ""
    var imageFile : String = ""
    var player: AVPlayer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource(imageFile, withExtension: "mp4")!
        
        player = AVPlayer(URL: videoURL)
        player?.actionAtItemEnd = .None
        player?.muted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = self.view.frame
        
        self.view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(VideoViewController.loopVideo),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: player?.currentItem)
        
        

        
//        let label = UILabel(frame: CGRectMake(0, 0, view.frame.width, 200))
//        label.textColor = UIColor.whiteColor()
//        label.text = titleText
//        label.textAlignment = .Center
//        view.addSubview(label)
//        
//        let button = UIButton(type: UIButtonType.System)
//        button.frame = CGRectMake(20, view.frame.height - 110, view.frame.width - 40, 50)
//        button.backgroundColor = UIColor(red: 138/255.0, green: 181/255.0, blue: 91/255.0, alpha: 1)
//        button.setTitle(titleText, forState: UIControlState.Normal)
//        self.view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
}
