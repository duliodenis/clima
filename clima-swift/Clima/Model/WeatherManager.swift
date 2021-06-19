//
//  WeatherManager.swift
//  Clima
//
//  Created by Dulio Denis on 6/13/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

let API_KEY = "YOUR_API_KEY"

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(API_KEY)&units=imperial"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(temp: temp, cityName: name, conditionId: id)
            
            print(weather.conditionName)
            print(weather.temperatureString)
        } catch {
            print(error)
        }
    }
}
