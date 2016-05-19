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
    override func drawRect(rect: CGRect) {
        
        let gaugeWidth = self.bounds.width
        let context = UIGraphicsGetCurrentContext()
        let color = UIColor.redColor().CGColor
        
        
        CGContextSetLineWidth(context, 4.0)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, CGFloat(gaugeValue), 0)
        CGContextAddLineToPoint(context, CGFloat(gaugeValue), 4)
        CGContextAddLineToPoint(context, 0, 4)
        CGContextSetFillColorWithColor(context, color)
        CGContextFillPath(context)
        
        
        
    }

}
