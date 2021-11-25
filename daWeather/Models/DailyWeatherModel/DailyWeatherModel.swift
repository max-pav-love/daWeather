//
//  DailyWeatherModel.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation

struct DailyWeatherModel {
    let cityName: String
    let temperature: String
    let description: String
    let maxTemp: String
    let minTemp: String
    let feelsLike: Double
    let humidity: Double
    let id: String
    let visibility: Int
    let pressure: Int
    let windSpeed: Double
    var minMaxTemp: String {
        return "Макс. \(maxTemp), мин. \(minTemp)"
    }
}
