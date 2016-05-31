//
//  AnswerLabel.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 22/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

struct Appearance {
    static var opponentColor = UIColor(red: 0.142954, green: 0.60323, blue: 0.862548, alpha: 0.88)
    static var userColor = UIColor(red:0.41, green:0.47, blue:0.93, alpha:1.0)
    static var font: UIFont = UIFont.systemFontOfSize(17.0)
}

class MessageBubbleTextView : UITextView {
    
    var subId: String?
    var answerId: String?
    
    override init(frame: CGRect = CGRectZero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        self.font = Appearance.font
        self.scrollEnabled = false
        self.editable = false
        self.textContainerInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        self.layer.masksToBounds = false
        self.font = UIFont(name: "Avenir-Medium", size: self.font!.pointSize)
    }
    
    required internal init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}