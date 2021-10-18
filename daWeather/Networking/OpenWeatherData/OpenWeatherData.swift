//
//  OpenWeatherData.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
}

// MARK: - List
struct List: Codable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let dt_txt: String
    let clouds: Clouds
    let wind: Wind
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct Main: Codable {
    let temp, feels_like, temp_min, temp_max: Double
    let humidity: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

// MARK: - DAILY WEATHER DATA
struct DailyWeatherMain: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}

struct DailyWeather: Codable {
    let main: DailyWeatherMain
    let name: String
    let id: Int
    let weather: [WeatherDescription]
}

struct WeatherDescription: Codable {
    let description: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

