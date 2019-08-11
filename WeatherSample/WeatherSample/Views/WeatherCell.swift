//
//  WeatherCell.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

class WeatherCell: WeatherViewCell {
    
    override var item: WeatherData! {
        didSet{
            
            let max  = Int(item.main?.tempMax ?? 0)
            let min  = Int(item.main?.tempMin ?? 0)
            let temp = Int(item.main?.temp ?? 0)
            
            tempLabel.text = "\(temp) ºC"
            minLabel.text  = "Min \(min) ºC"
            maxLabel.text  = "Max \(max) ºC"
            descriptionLabel.text = item.weather?.first?.description
        }
    }
}
