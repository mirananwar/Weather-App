//
//  WeatherModel.swift
//  Weather
//
//  Created by Mirana Abrar Anwar on 8/15/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let description: String
    let windSpeed: Double
    
    var temperatureString: String{
        return String(format: "%0.1f", temperature)
    }
    var feelsLikeString: String {
        return String(format: "%0.1f", feelsLike)
    }
    var windSpeedString: String {
        return String(format: "%0.1f", windSpeed)
    }
    

    var conditionName: String{
        switch conditionId {
           case 200...232:
               return "bolt"
           case 300...321:
               return "rain"
           case 500...531:
               return "rain"
           case 600...622:
               return "snow"
           case 701...781:
               return "fog"
           case 800:
               return "sun"
           case 801...804:
               return "cloud"
           default:
               return "cloud"
           }
    }
}
    
