//
//  WeatherData.swift
//  Weather
//
//  Created by Mirana Abrar Anwar on 8/15/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind : Wind
    
}
struct Main: Codable {
    let temp: Double
    let feels_like: Double
    
}
struct Weather: Codable {
    let id: Int
    let description: String
}

struct Wind: Codable {
    let speed: Double
}
