//
//  MessageCell.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 17/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class ChoiceCell: UITableViewCell {
    
    // MARK: Global MessageCell Appearance Modifier
    
    struct Appearance {
        static var opponentColor = UIColor(red: 0.142954, green: 0.60323, blue: 0.862548, alpha: 0.88)
        static var userColor = UIColor(red: 0.14726, green: 0.838161, blue: 0.533935, alpha: 1)
        static var font: UIFont = UIFont.systemFontOfSize(17.0)
    }
    
    /*
     These methods are included for ObjC compatibility.  If using Swift, you can set the Appearance variables directly.
     */
    
    class func setAppearanceOpponentColor(opponentColor: UIColor) {
        Appearance.opponentColor = opponentColor
    }
    
    class func setAppearanceUserColor(userColor: UIColor) {
        Appearance.userColor = userColor
    }
    
    class  func setAppearanceFont(font: UIFont) {
        Appearance.font = font
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        for v in self.subviews {
            v.layer.shadowColor = UIColor(red:0.14, green:0.35, blue:0.73, alpha:1.0).CGColor
            v.layer.shadowOffset = CGSize(width: 0, height: 0)
            v.layer.shadowOpacity = 0.1
            v.layer.shadowRadius = 5
        }
    }
    
    // MARK: Sizing
    
    private let padding: CGFloat = 5.0
    
    private let minimumHeight: CGFloat = 30.0 // arbitrary minimum height
    
    private var size = CGSizeZero
    
    private var maxSize: CGSize {
        get {
            let maxWidth = CGRectGetWidth(self.bounds) * 0.75 // Cells can take up to 3/4 of screen
            let maxHeight = CGFloat.max
            return CGSize(width: maxWidth, height: maxHeight)
        }
    }
    
    // MARK: Setup Call
    
    /*!
     Use this in cellForRowAtIndexPath to setup the cell.
     */
    func setupWithMessage(answers: [[String:AnyObject]], subId: String = "") -> CGSize {
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        var totalSize = CGSizeZero
        
        let topLabel = UITextView(frame: CGRectZero, textContainer: nil)
        topLabel.text = "Répondre à Guillaume"
        
        topLabel.contentInset = UIEdgeInsetsMake(-3, 0, 0, 0)
        
        topLabel.scrollEnabled = false
        
        topLabel.textColor = UIColor(red:0.94, green:0.97, blue:1.00, alpha:1.0)
        topLabel.backgroundColor = waterSkyBlue
        
        topLabel.font = UIFont(name: "Avenir-Medium", size: topLabel.font!.pointSize)
        self.contentView.addSubview(topLabel)
        
        
        size = topLabel.sizeThatFits(maxSize)
        if size.height < minimumHeight {
            size.height = minimumHeight
        }
        
        size.height = size.height - 9
        
        topLabel.bounds.size = size
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = topLabel.bounds
        maskLayer.path = UIBezierPath(roundedRect: topLabel.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.TopRight), cornerRadii: CGSizeMake(10, 10)).CGPath
        topLabel.layer.mask = maskLayer
        
        self.styleTextView(topLabel, prevHeight: totalSize.height)
        totalSize = size
        
        totalSize.height += padding
        
        for answer in answers {
            let textView: MessageBubbleTextView = {
                let textView = MessageBubbleTextView(frame: CGRectZero, textContainer: nil)
                self.contentView.addSubview(textView)
                return textView
            }()
            textView.text = answer["content"] as? String
            size = textView.sizeThatFits(maxSize)
            if size.height < minimumHeight {
                size.height = minimumHeight
            }
            textView.answerId = answer["id"] as? String
            textView.subId = subId
            
            textView.bounds.size = size
            
            textView.textColor = waterSkyBlue
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = textView.bounds
            maskLayer.path = UIBezierPath(roundedRect: textView.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.BottomLeft), cornerRadii: CGSizeMake(10, 10)).CGPath
            textView.layer.mask = maskLayer
            
            
            let borderLayer = CAShapeLayer()
            borderLayer.path = maskLayer.path
            borderLayer.fillColor = UIColor.clearColor().CGColor
            borderLayer.strokeColor = waterSkyBlue.CGColor
            borderLayer.lineWidth = 2
            borderLayer.frame = textView.bounds
            textView.layer.addSublayer(borderLayer)
            
            
            totalSize.width = size.width > totalSize.width ? size.width : totalSize.width
            
            self.styleTextView(textView, prevHeight: totalSize.height)
            
            totalSize.height += size.height + padding
            
        }
        
        return totalSize
    }
    
    // MARK: TextBubble Styling
    
    private func styleTextView(textView: UIView, prevHeight: CGFloat) {
        let halfTextViewWidth = CGRectGetWidth(textView.bounds) / 2.0
        let targetX = halfTextViewWidth + padding * 4
        let halfTextViewHeight = CGRectGetHeight(textView.bounds) / 2.0
        textView.center.x = CGRectGetWidth(self.bounds) - targetX
        textView.center.y = halfTextViewHeight + prevHeight + (padding / 2)
        
    }
}
