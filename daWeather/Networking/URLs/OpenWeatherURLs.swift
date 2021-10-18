//
//  OpenWeatherURLs.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation

// MARK: - PUT YOUR API-KEY HERE

private let apiKey = "de9b38761be0a1d3dbd2eb8acbdd75c1"

// MARK: - OpenWeather URLs

let dailyUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=\(apiKey)&units=metric&lang=ru"

let forecastUrl = "https://api.openweathermap.org/data/2.5/forecast?&appid=\(apiKey)&units=metric&lang=ru"
