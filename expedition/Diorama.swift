//
//  Diorama.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 02/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
import AVFoundation

class Diorama: UIView {
    
    var sky: UIView = UIView(frame: CGRectMake(0,0,0,0))
    
    var layers : [Layer] = []
    
    var heights : [CGFloat] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(sky)
        
        var cpt = 0
        for i in 4.stride(to: 0, by: -1){
            
            layers.append(Layer(frame: CGRectMake(0, 0, self.frame.width * 7, self.frame.height), name: "diorama_layer" + String(i), i: cpt))
            
            heights.append(layers.last!.image!.size.height)
            
            self.addSubview(layers.last!)
            cpt += 1
        }

        let maxHeight = heights.maxElement()

        for layer in layers {
            
            let layerHeight = layer.image?.size.height
            
            let framePerc = layerHeight! / maxHeight!

            let frameHeight = self.frame.height * framePerc
            
            layer.yO = 0
            layer.frame = CGRectMake(0, layer.yO!, layer.frame.width, frameHeight)
        }

        sky.frame = CGRectMake(0, 0, self.frame.width, frame.height/2)
        let layer = CAGradientLayer()
        layer.frame = sky.bounds
        layer.colors = [
            UIColor(red:74/255, green:80/255, blue:254/255, alpha:1).CGColor,
            skyBlue.CGColor,
            skyBlue2.CGColor,
            skyBlue3.CGColor,
            skyBlue4.CGColor,
            skyBlue5.CGColor,
            skyBlue6.CGColor
        ]
        sky.layer.addSublayer(layer)
    }
    
    class Layer: UIImageView {
        
        let index: Int
        
        var yO: CGFloat?
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init(frame: CGRect, name: String, i: Int) {
            index = i
            super.init(frame: frame)
            image = UIImage(named: name)
        }
                    
    }
    
}
