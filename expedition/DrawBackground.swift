//
//  DrawBackground.swift
//  expedition
//
//  Created by J.C Gigonnet on 17/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class DrawBackground: UIView {
    
    override func drawRect(rect: CGRect) {
        
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let context = UIGraphicsGetCurrentContext()
        let color = waterSkyBlue3.CGColor
        
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, screenWidth + 8, 0)
        CGContextAddLineToPoint(context, screenWidth + 8, 90)
        CGContextAddQuadCurveToPoint(context, screenWidth/2, 25, 0, 90)
        CGContextAddLineToPoint(context, 0, 0)
        CGContextSetFillColorWithColor(context, color)
        CGContextFillPath(context)
        
        let secondCurvePath = UIBezierPath()
        secondCurvePath.moveToPoint(CGPointMake(0, 0))
        secondCurvePath.addLineToPoint(CGPointMake(screenWidth + 8, 0))
        secondCurvePath.addLineToPoint(CGPointMake(screenWidth + 8, 80))
        secondCurvePath.addQuadCurveToPoint(CGPointMake(0, 80), controlPoint: CGPointMake(screenWidth/2, 25))
        secondCurvePath.closePath()
        waterSkyBlue2.setFill()
        secondCurvePath.fill()
        
        let thirdCurvePath = UIBezierPath()
        thirdCurvePath.moveToPoint(CGPointMake(0, 0))
        thirdCurvePath.addLineToPoint(CGPointMake(screenWidth + 8, 0))
        thirdCurvePath.addLineToPoint(CGPointMake(screenWidth + 8, 70))
        thirdCurvePath.addQuadCurveToPoint(CGPointMake(0, 70), controlPoint: CGPointMake(screenWidth/2, 25))
        thirdCurvePath.closePath()
        waterSkyBlue.setFill()
        thirdCurvePath.fill()
        
        
    }
}
