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
    let feelsLike: String
    let humidity: String
    let id: String
    var minMaxTemp: String {
        return "Макс. \(maxTemp), мин. \(minTemp)"
    }
}
