//
//  Subsituation.swift
//  expedition
//
//  Created by Thomas BOULONGNE🌚 on 10/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import Foundation

class Subsituation {
    
    var content: String?
    let id: String
    let type: String
    let child_id: String
    var received: String?
    var answers: Array<Answer>?
    
    init(id: String, child_id : String, type: String) {
        self.child_id = child_id
        self.type = type
        self.id = id
        self.received = "true"
    }
    
}