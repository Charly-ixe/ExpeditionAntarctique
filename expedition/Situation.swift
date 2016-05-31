//
//  File.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 11/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import Foundation

class Situation {
    
    var subs: Array<Subsituation>
    let id: String
    let place: String
    let name: String
    let delay: Double
    
    init(id: String, place: String, name: String, delay: Double = 1) {
        self.id = id
        
        self.place = place
        
        self.name = name
        
        self.subs = []
        
        self.delay = delay
    }
}