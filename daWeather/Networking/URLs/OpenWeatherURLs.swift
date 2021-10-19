//
//  OpenWeatherURLs.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation

// MARK: - PUT YOUR API-KEY HERE

private let apiKey = "PUT_YOUR_API_KEY_HERE"

// MARK: - OpenWeather URLs

let dailyUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=\(apiKey)&units=metric&lang=ru"

let forecastUrl = "https://api.openweathermap.org/data/2.5/forecast?&appid=\(apiKey)&units=metric&lang=ru"
