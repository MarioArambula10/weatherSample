//
//  Constants.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//


import UIKit


public enum ViewTags: Int {
    
    case activityIndicator = 100000
}


public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}


public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}


public var multiPartFormDataBoundary: String {
    return "--WebKitFormBoundary7MA4YWxkTrZu0gW"
}


public struct ImageNames {
    
    static let background = "mountain"
    static let weatherIcon = "icon"
}


public struct FontNames {
    
    struct HelveticaNeue {
        
        static let regular = "HelveticaNeue"
        static let bold = "HelveticaNeue-Bold"
        static let light = "HelveticaNeue-Light"
        static let ultraLight = "HelveticaNeue-UltraLight"
    }
}


public struct DateFormat {
    
    static let custom = "EEEE, d MMMM"
}


public struct Colors {
    
    static let customLightGray = UIColor(netHex: 0xEDEDED)
    static let customMediumGray = UIColor(netHex: 0x646464)
    static let customDarkGray = UIColor(netHex: 0x252525)
    static let customBlue = UIColor(netHex: 0x72BCD4)
}
