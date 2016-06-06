//
//  MapElementUIView.swift
//  expedition
//
//  Created by J.C Gigonnet on 31/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class MapElementUIView: UIView {
    var elementFrame : CGRect
    var name : String
    var elementDescription : String
    var img : String
    var btn : UIButton?
    
    init(frame : CGRect, name: String, eltDescription: String, img: String) {
        self.elementFrame = frame
        self.name = name
        self.elementDescription = eltDescription
        self.img = img
        
        
        let placeImg = UIImageView(image: UIImage(named: self.img))
        placeImg.frame = CGRectMake(0, 0, self.elementFrame.width, self.elementFrame.height)
        placeImg.bounds.size = self.elementFrame.size
        placeImg.contentMode = UIViewContentMode.ScaleAspectFill
        placeImg.clipsToBounds = true
        placeImg.userInteractionEnabled = true
        
        btn = UIButton(type: .Custom)
        btn!.frame = placeImg.frame
        btn!.bounds.size = elementFrame.size
        btn!.clipsToBounds = true
        btn!.userInteractionEnabled = true
//        btn!.setTitle("Tap", forState: .Normal)
        
//        let button = UIButton(type: .Custom) as UIButton
//        button.frame = placeImg.frame
//        button.bounds.size = elementFrame.size
//        button.setTitle("Tap", forState: .Normal)
        
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.addSubview(placeImg)
        btn!.addTarget(self, action: #selector(FirstViewController.tapElement(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.bringSubviewToFront(btn!)
        
        placeImg.addSubview(btn!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
