//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit
import CoreData

class CitiesViewModel {
    
    var cities: [Weather] = []
    
    init(weatherData: [String: Any]?) {
        if let weatherData = weatherData {
            if let list = weatherData["list"] as? [[String: Any]] {
                deleteCoreData()
                for city in list {
                    let name = city["name"] as? String ?? ""
                    let id = city["id"] as? String ?? ""
                    if let main = city["main"] as? [String: Any] {
                        let feels_like = main["feels_like"] as? Double ?? 0
                        let humidity = main["humidity"] as? Double ?? 0
                        let pressure = main["pressure"] as? Double ?? 0
                        let temp = main["temp"] as? Double ?? 0
                        let temp_max = main["temp_max"] as? Double ?? 0
                        let temp_min = main["temp_min"] as? Double ?? 0
                        
                        let weather = Weather(id: id, cityName: name, temp: temp, feels_like: feels_like, temp_min: temp_min, temp_max: temp_max, pressure: pressure, humidity: humidity)
                        createWeatherDataEntity(weather: weather)
                    }
                }
            }
        }
        
        setWeahterData()
    }
    
    func createWeatherDataEntity(weather: Weather) {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        if let weatherDataEntity = NSEntityDescription.insertNewObject(forEntityName: "WeatherData", into: context) as? WeatherData {
            weatherDataEntity.id = weather.id ?? ""
            weatherDataEntity.cityName = weather.cityName ?? ""
            weatherDataEntity.temp = weather.temp ?? 0
            weatherDataEntity.feels_like = weather.feels_like ?? 0
            weatherDataEntity.temp_min = weather.temp_min ?? 0
            weatherDataEntity.temp_max = weather.temp_max ?? 0
            weatherDataEntity.pressure = weather.pressure ?? 0
            weatherDataEntity.humidity = weather.humidity ?? 0
            
        }
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func fetchWeatherData() -> [WeatherData] {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "cityName", ascending: true)]
        
        do
        {
            let test = try context.fetch(fetchRequest)
            if test.count > 0 {
                if let weatherData = test as? [WeatherData]{
                    return weatherData
                }
            }
        }
        catch
        {
            print(error)
        }
        return []
    }
    
    func setWeahterData() {
        let weatherData = fetchWeatherData()
        self.cities = [Weather]()
        for weather in weatherData {
            let id = weather.id
            let name = weather.cityName
            let feels_like = weather.feels_like
            let humidity = weather.humidity
            let pressure = weather.pressure
            let temp = weather.temp
            let temp_max = weather.temp_max
            let temp_min = weather.temp_min
            
            let _weather = Weather(id: id, cityName: name, temp: temp, feels_like: feels_like, temp_min: temp_min, temp_max: temp_max, pressure: pressure, humidity: humidity)
            self.cities.append(_weather)
        }
    }
    
    func deleteCoreData() {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                if let _object = object as? NSManagedObject {
                    context.delete(_object)
                }
            }
            do {
                try context.save() // <- remember to put this :)
            } catch let err{
                // Do something... fatalerror
                print(err.localizedDescription)
            }
        }
    }
}
