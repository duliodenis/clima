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
        print(urlString)
    }
}
