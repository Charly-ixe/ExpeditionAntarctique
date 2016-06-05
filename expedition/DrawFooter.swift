//
//  DrawFooter.swift
//  expedition
//
//  Created by J.C Gigonnet on 05/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class DrawFooter: UIView {
    override func drawRect(rect: CGRect) {
        
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let context = UIGraphicsGetCurrentContext()
        let color = waterSkyBlue3.CGColor
        
        CGContextMoveToPoint(context, 0, 70)
        CGContextAddQuadCurveToPoint(context, screenWidth/2, 30, screenWidth + 8, 70)
        CGContextAddLineToPoint(context, screenWidth + 8, 300)
        CGContextAddLineToPoint(context, 0, 300)
        CGContextAddLineToPoint(context, 0, 70)
        CGContextSetFillColorWithColor(context, color)
        CGContextFillPath(context)
        
        let secondCurvePath = UIBezierPath()
        secondCurvePath.moveToPoint(CGPointMake(0, 80))
        secondCurvePath.addQuadCurveToPoint(CGPointMake(screenWidth + 8, 80), controlPoint: CGPointMake(screenWidth/2, 32))
        secondCurvePath.addLineToPoint(CGPointMake(screenWidth + 8, 300))
        secondCurvePath.addLineToPoint(CGPointMake(0, 300))
        secondCurvePath.closePath()
        waterSkyBlue2.setFill()
        secondCurvePath.fill()
        
        let thirdCurvePath = UIBezierPath()
        thirdCurvePath.moveToPoint(CGPointMake(0, 90))
        thirdCurvePath.addQuadCurveToPoint(CGPointMake(screenWidth + 8, 90), controlPoint: CGPointMake(screenWidth/2, 34))
        thirdCurvePath.addLineToPoint(CGPointMake(screenWidth + 8, 300))
        thirdCurvePath.addLineToPoint(CGPointMake(0, 300))
        thirdCurvePath.closePath()
        waterSkyBlue.setFill()
        thirdCurvePath.fill()
        
        
    }
}
