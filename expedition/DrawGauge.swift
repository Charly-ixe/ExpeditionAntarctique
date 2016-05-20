//
//  DrawGauge.swift
//  expedition
//
//  Created by J.C Gigonnet on 19/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class DrawGauge: UIView {
    var gaugeValue = 100.0
    var color = UIColor.greenColor().CGColor
    override func drawRect(rect: CGRect) {
        
        let gaugeWidth = self.bounds.width
        let context = UIGraphicsGetCurrentContext()
//        var color = UIColor.greenColor().CGColor
//        if gaugeValue < 10.0 {
//            color = UIColor.redColor().CGColor
//        }
//        else if gaugeValue > 10 && gaugeValue < 25 {
//            color = UIColor.yellowColor().CGColor
//        }
//        else {
//            color = UIColor.greenColor().CGColor
//        }
        
        
        CGContextSetLineWidth(context, 4.0)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, (CGFloat(gaugeValue)/100) * gaugeWidth, 0)
        CGContextAddLineToPoint(context, (CGFloat(gaugeValue)/100) * gaugeWidth, 4)
        CGContextAddLineToPoint(context, 0, 4)
        CGContextSetFillColorWithColor(context, color)
        CGContextFillPath(context)
        
        
        
    }
    func setNewColor(gaugeValue : CGFloat) -> CGColor {
        if gaugeValue <= 25.0 {
            color = UIColor.redColor().CGColor
        }
        else if gaugeValue > 25.0 && gaugeValue <= 50.0 {
            color = UIColor.yellowColor().CGColor
            print("drought")
        }
        else {
            color = UIColor.greenColor().CGColor
        }
        return color
    }

}
