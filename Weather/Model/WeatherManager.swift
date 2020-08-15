//
//  WeatherManager.swift
//  Weather
//
//  Created by Mirana Abrar Anwar on 8/15/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?units=metric&appid="
    let apiKey = "insert-api-key"

    var delegate: WeatherManagerDelegate?
    

    func fetchWeather(cityName:String){
        let urlString = "\(weatherURL)\(apiKey)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        // 1. create a url
        if let url = URL(string: urlString){
            // 2. create a url session
            
            let session = URLSession(configuration: .default)
            // 3. give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)

                    }
                }
            }
            // 4. start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let feelsLike = decodedData.main.feels_like
            let name = decodedData.name
            let desc = decodedData.weather[0].description
            let windSpeed = decodedData.wind.speed
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, feelsLike: feelsLike, description: desc, windSpeed: windSpeed)
            return weather
            
        }  catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    func fetchWeather(latitude: Double, longitude: Double){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
}

