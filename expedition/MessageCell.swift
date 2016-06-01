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
    
    
    
    private lazy var container: ContainerView = {
        let container = ContainerView(frame: CGRectZero)
        
        self.contentView.addSubview(container)
        return container
    }()
    
    private class ContainerView : UIView {
        
        override init(frame: CGRect = CGRectZero) {
            super.init(frame: frame)
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
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
    
    private lazy var imgView: MessageBubbleImageView = {
        let imgView = MessageBubbleImageView(frame: CGRectZero)
        self.contentView.addSubview(imgView)
        return imgView
    }()
    
    private class MessageBubbleImageView : UIImageView {
        
        override init(frame: CGRect = CGRectZero) {
            super.init(frame: frame)
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
        let content = message["content"] as? String
        
        
        if content!.rangeOfString("{{") != nil{
            textView.removeFromSuperview()
            container.removeFromSuperview()
            self.contentView.addSubview(imgView)
            // is image
            var named = content!.stringByReplacingOccurrencesOfString("{", withString: "")
            named = named.stringByReplacingOccurrencesOfString("}", withString: "")
            
            imgView.image = UIImage(named: named)
            
            let newHeight = (maxSize.width * imgView.image!.size.height) / imgView.image!.size.width
            
            size.height = newHeight
            size.width = maxSize.width
            
            imgView.bounds.size = size
            
            imgView.contentMode = UIViewContentMode.ScaleAspectFill
            imgView.clipsToBounds = true
            
            self.styleImgViewForSentBy("true")
            
            size.height = size.height + padding * 3
        }
        else if content!.rangeOfString("==typing==") != nil{
            textView.removeFromSuperview()
            imgView.removeFromSuperview()
            container.addSubview(imgView)
            self.contentView.addSubview(container)
            imgView.image = UIImage.gifWithName("typing")
            
            let newHeight = (20 * imgView.image!.size.height) / imgView.image!.size.width
            
            size.height = newHeight + 10
            size.width = 40
            
            imgView.bounds.size = size
            
            imgView.contentMode = UIViewContentMode.ScaleAspectFill
            container.clipsToBounds = true
            
            size.height = 37.5
            size.width = 60
            container.bounds.size = size
            size.height = size.height + padding * 2
            self.styleTypeViewForSentBy(container, h: size.height)
            
        }
        else {
            self.contentView.addSubview(textView)
            imgView.removeFromSuperview()
            container.removeFromSuperview()
            textView.text = content
            
            textView.font = UIFont(name: "Avenir-Medium", size: textView.font!.pointSize)
            size = textView.sizeThatFits(maxSize)
            if size.height < minimumHeight {
                size.height = minimumHeight
            }
            textView.bounds.size = size
            
            self.styleTextViewForSentBy(message["received"] as! String)
            
            size.height = size.height + padding
        }
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
    
    // MARK: ImgBubble Styling
    
    private func styleImgViewForSentBy(sentBy: String) {
        let halfTextViewWidth = CGRectGetWidth(self.imgView.bounds) / 2.0
        let targetX = halfTextViewWidth + padding * 4
        let halfTextViewHeight = CGRectGetHeight(self.imgView.bounds) / 2.0
        self.textView.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
        switch sentBy {
        case "true":
            self.imgView.center.x = targetX
            self.imgView.center.y = halfTextViewHeight + (padding / 2)
            self.imgView.layer.borderColor = Appearance.opponentColor.CGColor
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = imgView.bounds
            maskLayer.path = UIBezierPath(roundedRect: imgView.bounds, byRoundingCorners: UIRectCorner.TopRight.union(.BottomRight).union(.TopLeft), cornerRadii: CGSizeMake(10, 10)).CGPath
            imgView.layer.mask = maskLayer
        default:
            break
        }
    }
    
    // MARK: Typing Styling
    
    private func styleTypeViewForSentBy(container: UIView, h: CGFloat) {
        let halfTextViewWidth = CGRectGetWidth(self.container.bounds) / 2.0
        let targetX = halfTextViewWidth + padding * 3
        let halfTextViewHeight = h / 2.0
        container.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
        container.center.x = targetX + padding
        container.center.y = halfTextViewHeight + (padding / 2)
        container.layer.borderColor = Appearance.opponentColor.CGColor
        
        imgView.center.x = container.center.x - (imgView.bounds.width / 2)
        imgView.center.y = container.center.y - (imgView.bounds.height / 4)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = container.bounds
        maskLayer.path = UIBezierPath(roundedRect: container.bounds, byRoundingCorners: UIRectCorner.TopRight.union(.BottomRight).union(.TopLeft), cornerRadii: CGSizeMake(10, 10)).CGPath
        container.layer.mask = maskLayer
    }
}
