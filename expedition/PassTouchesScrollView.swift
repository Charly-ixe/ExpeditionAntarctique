//
//  PassTouchesScrollView.swift
//  expedition
//
//  Created by J.C Gigonnet on 07/06/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

protocol PassTouchesScrollViewDelegate {
    func touchBegan()
    func touchMoved()
}


class PassTouchesScrollView: UIScrollView {

    var delegatePass : PassTouchesScrollViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Notify it's delegate about touched
        self.delegatePass?.touchBegan()
        
        if self.dragging == true {
            self.nextResponder()?.touchesBegan(touches, withEvent: event)
        } else {
            super.touchesBegan(touches, withEvent: event)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // Notify it's delegate about touched
        self.delegatePass?.touchMoved()
        
        if self.dragging == true {
            self.nextResponder()?.touchesMoved(touches, withEvent: event)
        } else {
            super.touchesMoved(touches, withEvent: event)
        }
    }
    
//    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        var result : UIView = nil
//        for child in self.subviews {
//            if child.pointInside(point, withEvent: event) {
//                if (result = child.hitTest(point, withEvent: event)) != nil {
//                    break
//                }
//            }
//        }
//        return result
//    }

}
