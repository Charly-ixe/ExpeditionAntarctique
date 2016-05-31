//
//  MessageCell.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 17/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // MARK: Global MessageCell Appearance Modifier
    
    struct Appearance {
        static var opponentColor = UIColor(red:0.04, green:0.14, blue:0.31, alpha:1.0)
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
    
    // MARK: Message Bubble TextView
    
    private lazy var textView: MessageBubbleTextView = {
        let textView = MessageBubbleTextView(frame: CGRectZero, textContainer: nil)
        self.contentView.addSubview(textView)
        return textView
    }()
    
    private class MessageBubbleTextView : UITextView {
        
        override init(frame: CGRect = CGRectZero, textContainer: NSTextContainer? = nil) {
            super.init(frame: frame, textContainer: textContainer)
            self.font = Appearance.font
            self.scrollEnabled = false
            self.editable = false
            self.textContainerInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    // MARK: ImageView
    
    
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
    func setupWithMessage(message: [String:AnyObject]) -> CGSize {
        textView.text = message["content"] as? String
        
        textView.font = UIFont(name: "Avenir-Medium", size: textView.font!.pointSize)
        size = textView.sizeThatFits(maxSize)
        if size.height < minimumHeight {
            size.height = minimumHeight
        }
        textView.bounds.size = size
        
        self.styleTextViewForSentBy(message["received"] as! String)
        
        size.height = size.height + padding
        
        return size
    }
    
    // MARK: TextBubble Styling
    
    private func styleTextViewForSentBy(sentBy: String) {
        let halfTextViewWidth = CGRectGetWidth(self.textView.bounds) / 2.0
        let targetX = halfTextViewWidth + padding * 4
        let halfTextViewHeight = CGRectGetHeight(self.textView.bounds) / 2.0
        self.textView.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
        self.textView.textColor = Appearance.opponentColor
        switch sentBy {
        case "true":
            self.textView.center.x = targetX
            self.textView.center.y = halfTextViewHeight + (padding / 2)
            self.textView.layer.borderColor = Appearance.opponentColor.CGColor
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = textView.bounds
            maskLayer.path = UIBezierPath(roundedRect: textView.bounds, byRoundingCorners: UIRectCorner.TopRight.union(.BottomRight).union(.TopLeft), cornerRadii: CGSizeMake(10, 10)).CGPath
            textView.layer.mask = maskLayer
            
            
            
        case "false":
            self.textView.center.x = CGRectGetWidth(self.bounds) - targetX
            self.textView.center.y = halfTextViewHeight + (padding / 2)
            self.textView.layer.borderColor = Appearance.userColor.CGColor
            
            
            
            self.textView.textColor = UIColor(red:0.94, green:0.97, blue:1.00, alpha:1.0)
            self.textView.backgroundColor = UIColor(red:0.49, green:0.56, blue:0.95, alpha:1.0)
            
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = textView.bounds
            maskLayer.path = UIBezierPath(roundedRect: textView.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.BottomLeft).union(.TopRight), cornerRadii: CGSizeMake(10, 10)).CGPath
            textView.layer.mask = maskLayer
            
        default:
            break
        }
    }
}
