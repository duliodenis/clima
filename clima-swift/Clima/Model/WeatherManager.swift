//
//  WeatherManager.swift
//  Clima
//
//  Created by Dulio Denis on 6/13/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

let API_KEY = "YOUR_API_KEY"

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherData: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(API_KEY)&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        print("Step 1. In the Manager performing a JSON parse")
                        delegate?.didUpdateWeather(self, weatherData: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(temp: temp, cityName: name, conditionId: id)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
