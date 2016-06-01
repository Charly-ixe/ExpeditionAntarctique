//
//  MapElementUIView.swift
//  expedition
//
//  Created by J.C Gigonnet on 31/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class MapElementUIView: UIView {
    var elementFrame : CGRect
    var name : String
    var elementDescription : String
    
    init(frame : CGRect, name: String, eltDescription: String) {
        self.elementFrame = frame
        self.name = name
        self.elementDescription = eltDescription
        
        let button = UIButton(frame: self.elementFrame)
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
