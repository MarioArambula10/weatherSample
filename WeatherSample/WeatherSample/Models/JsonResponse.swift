//
//  JsonResponse.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import Foundation

struct JsonResponse<T: Codable>: Codable {
    
    var cod: String!
    var message: Double!
    var data: T?
    
    private enum CodingKeys: String, CodingKey {
        
        case cod, message
        case data = "list"
    }
}
