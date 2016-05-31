//
//  Helper.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 28/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import Foundation

class Helper{
    static func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
}