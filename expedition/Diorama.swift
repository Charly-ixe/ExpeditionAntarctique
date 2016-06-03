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
    
    var layers : [Layer] = []
    
    var heights : [CGFloat] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        for i in 4.stride(to: 0, by: -1){
            layers.append(Layer(frame: CGRectMake(0, 100, self.frame.width * 7, self.frame.height), name: "diorama_layer" + String(i)))
            
            heights.append(layers.last!.image!.size.height)
            
            self.addSubview(layers.last!)
        }

        let maxHeight = heights.maxElement()

        for layer in layers {
            
            let layerHeight = layer.image?.size.height
            
            let framePerc = layerHeight! / maxHeight!

            let frameHeight = self.frame.height * framePerc
            
            print(frameHeight)
            
//            let newWidth = sizeRatio!.width * self.frame.height / maxHeight!
//            
//            print(self.frame.height)
//            print(newWidth)

            layer.frame = CGRectMake(0, self.frame.height - frameHeight, layer.frame.width, frameHeight)
        }

    }
    
    class Layer: UIImageView {
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init(frame: CGRect, name: String) {
            super.init(frame: frame)
            image = UIImage(named: name)
        }
                    
    }
    
}
