//
//  Error.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//


struct GenericError: Error {
    
    var type: AppError.Generic
    var description: String?
    
    init(type: AppError.Generic) {
        
        self.type = type
        self.description = type.rawValue
    }
    
    init(description: String) {
        
        self.type = .custom
        self.description = description
    }
}


struct AppError {
    
    enum Generic: String, Error {
        
        case unexpected = "An unexpected error occur, please try again later."
        case netWork = "There seems to be a network connection error, please try again later."
        case jsonDecoding = "There was an issue decoding the json response."
        case custom
    }
}
