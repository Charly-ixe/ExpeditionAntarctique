//
//  Conversation.swift
//  expedition
//
//  Created by J.C Gigonnet on 08/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import Foundation


class Conversation {
    var conversationHistory : [Message] = []
    var currentMessage : String
    var currentPlace : String
    
    init() {
        currentMessage = ""
        currentPlace = ""
    }
    
    func setCurrentMessage() -> String {
        let last = conversationHistory.last
        currentMessage = last!.id
        
        return currentMessage
    }
    
    
}