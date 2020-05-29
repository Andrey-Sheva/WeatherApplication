//
//  WeatherModel.swift
//  WeatherApplication
//
//  Created by Андрей Шевчук on 29.05.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import Foundation

struct WeatherModel{
    let cityName: String
    let cityTemperature: Double
    let conditionId: Int
    
    var temperature: String {
        return String(format: "%.1f", cityTemperature)
    }
    
    var conditionName: String {
        switch conditionId {
           case 200...232:
               return "cloud.bolt"
           case 300...321:
               return "cloude.drizzle"
           case 500...531:
               return "cloud.rain"
           case 600...622:
               return "cloud.snow"
           case 701...781:
               return "cloud.fog"
           case 800:
               return "sun.max"
           case 801...804:
               return "cloud.bolt"
           default:
               return "cloud"
               }
    }
    
}
