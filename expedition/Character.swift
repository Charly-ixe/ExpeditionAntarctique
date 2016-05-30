//
//  Character.swift
//  expedition
//
//  Created by J.C Gigonnet on 24/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class Character: NSObject {
    var name: String
    var hunger: Double
    var drought: Double
    var moral: Double
    var teamSpirit: Double
    
    init(name: String) {
        self.name = name
        hunger = 100.0
        drought = 100.0
        moral = 100.0
        teamSpirit = 100.0
    }
    
}
