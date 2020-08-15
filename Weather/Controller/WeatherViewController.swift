//
//  ViewController.swift
//  Weather
//
//  Created by Mirana Abrar Anwar on 8/15/20.
//  Copyright © 2020 Mirana Anwar. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
}

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
}


//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
     @IBAction func searchPressed(_ sender: UIButton) {
         searchTextField.endEditing(true)
         print(searchTextField.text!)
     }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         searchTextField.endEditing(true)
         print(searchTextField.text!)
         return true
     }
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         if textField.text != ""{
             return true
         } else{
             textField.placeholder = "type smth"
             return false
         }
     }
     func textFieldDidEndEditing(_ textField: UITextField) {

         if let city = searchTextField.text{
             weatherManager.fetchWeather(cityName: city)
         }
         searchTextField.text = ""
     }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.backgroundImageView.image = UIImage(named: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.feelsLikeTemp.text = weather.feelsLikeString
            self.weatherDesc.text = weather.description
            self.windSpeed.text = weather.windSpeedString
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
