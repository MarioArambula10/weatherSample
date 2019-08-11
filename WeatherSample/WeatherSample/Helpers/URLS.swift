//
//  URLS.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import Foundation

class AppUrl {
    
    public static let shared = AppUrl()
    
    public func getStockholmWeatherForcastUrl() -> String {
        
        return baseUrl + "lat=\(StockholmCoords.lat)&lon=\(StockholmCoords.long)&" + "units=metric&" + "appid=\(appId)"
    }
    
    
    private let appId   = "93b6d73bce9ffad1ec528480c76689b2"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/forecast?"
    
    private struct StockholmCoords {
        
        static let lat: Double = 59.334591
        static let long: Double = 18.063240
    }
    
    private init() {}
}
