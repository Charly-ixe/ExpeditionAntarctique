//
//  Message.swift
//  expedition
//
//  Created by J.C Gigonnet on 22/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import Foundation

class Message {
    let id: String;
    let idSituation: String;
    var name: String;
    var idChild: String;
    var messageType: Int;
    var content: String = "";
    
    init(id : String, idSituation : String, name: String, idChild: String, messageType: Int) {
        self.id = id
        self.idSituation = idSituation
        self.name = name
        self.idChild = idChild
        self.messageType = messageType
    }
    
    
    
}
