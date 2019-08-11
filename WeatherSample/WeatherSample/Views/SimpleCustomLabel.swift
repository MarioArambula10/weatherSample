//
//  SimpleCustomLabel.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

class SimpleCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lineBreakMode = .byClipping
        textAlignment = .left
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontName: String, size: CGFloat, textColor: UIColor = .black, alignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        
        font = UIFont(name: fontName, size: size)
        self.textColor = textColor
        self.textAlignment = alignment
    }
}
