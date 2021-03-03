//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit

class CitiesViewModel {
    
    var cities: [Weather] = []
    
    init(weatherData: [String: Any]) {
        if let list = weatherData["list"] as? [[String: Any]] {
            self.cities = [Weather]()
            for city in list {
                let name = city["name"] as? String ?? ""
                let id = city["id"] as? String ?? ""
                if let main = city["main"] as? [String: Any] {
                    let feels_like = main["feels_like"] as? String ?? ""
                    let humidity = main["humidity"] as? String ?? ""
                    let pressure = main["pressure"] as? String ?? ""
                    let temp = main["temp"] as? String ?? ""
                    let temp_max = main["temp_max"] as? String ?? ""
                    let temp_min = main["temp_min"] as? String ?? ""
                    
                    let weather = Weather(id: id, cityName: name, temp: temp, feels_like: feels_like, temp_min: temp_min, temp_max: temp_max, pressure: pressure, humidity: humidity)
                    self.cities.append(weather)
                }
            }
        }
    }
    
}
