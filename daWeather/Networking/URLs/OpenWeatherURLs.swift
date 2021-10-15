//
//  OpenWeatherURLs.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation

let apiKey = "(YOUR_OPENWEATHERMAP_TOKEN_HERE)"

let dailyUrl = "https://api.openweathermap.org/data/2.5/weather?&q=london&appid=\(apiKey)&units=metric&lang=ru"

let forecastUrl = "https://api.openweathermap.org/data/2.5/forecast?&q=london&appid=\(apiKey)&units=metric&lang=ru"
