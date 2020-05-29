//
//  WeatherData.swift
//  WeatherApplication
//
//  Created by Андрей Шевчук on 29.05.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
    
}
struct Main: Codable{
    let temp: Double
}
struct Weather: Codable{
    let description: String
    let id: Int
}

struct Sys: Codable{
    let country: String
}


