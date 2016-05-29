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
        
        CGContextSetLineWidth(context, 4.0)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, (CGFloat(gaugeValue)/100) * gaugeWidth, 0)
        CGContextAddLineToPoint(context, (CGFloat(gaugeValue)/100) * gaugeWidth, 4)
        CGContextAddLineToPoint(context, 0, 4)
        CGContextSetFillColorWithColor(context, color)
        CGContextFillPath(context)
//        let gauge = UIView()
//        gauge.frame = CGRectMake(0, 0, (CGFloat(gaugeValue)/100) * gaugeWidth, 4)
//        gauge.backgroundColor = UIColor(CGColor: color)
//        self.addSubview(gauge)
        
    }
    func setNewColor(gaugeValue : CGFloat) -> CGColor {
        if gaugeValue <= 25.0 {
            color = gaugeRed.CGColor
        }
        else if gaugeValue > 25.0 && gaugeValue <= 50.0 {
            color = gaugeYellow.CGColor
        }
        else {
            color = gaugeGreen.CGColor
        }
        return color
    }
    
    func animateView(newSize : CGFloat) {
        UIView.animateWithDuration(0.3, animations: {
//            var newFrame = self.frame
//            newFrame.size.width = newSize
//            self.frame = newFrame
            
        })
    }

}
