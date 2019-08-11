//
//  Model.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import Foundation


struct WeatherData: Codable {
    
    var main: MainData?
    var weather: [Weather]?
}


struct MainData: Codable {
    
    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
    var humidity: Double?
    
    private enum CodingKeys: String, CodingKey {
        
        case temp, humidity
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}


struct Weather: Codable {
    
    var main: String?
    var description: String?
}
