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
            print("Decoded data: \(decodedData.name) \(decodedData.main.temp) \(decodedData.weather[0].description)")
        } catch {
            print(error)
        }
        
    }
}
