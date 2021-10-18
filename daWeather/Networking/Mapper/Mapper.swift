//
//  Mapper.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation

final class Mapper {
    
    var hours: [ForecastWeatherModel] = []
    
    var hour = ForecastWeatherModel(conditionId: "", date: "", temp: "")
    
    var day = DailyWeatherModel(cityName: "", temperature: "",
                                description: "", maxTemp: "",
                                minTemp: "", feelsLike: "",
                                humidity: "", id: "")
    
    func mapDay(weather: DailyWeather) -> DailyWeatherModel {
        day = DailyWeatherModel(cityName: weather.name,
                                temperature: tempPresenter(for:weather.main.temp),
                                description: weather.weather[0].description.capitalizingFirstLetter(),
                                maxTemp: tempPresenter(for: weather.main.temp_max),
                                minTemp: tempPresenter(for: weather.main.temp_min),
                                feelsLike: weather.main.feels_like.description,
                                humidity: weather.main.humidity.description,
                                id: getIconSystemName(by: weather.id))
        return day
    }
    
    func map(weather: Forecast) -> [ForecastWeatherModel] {
        
        
        for i in weather.list {
            let temp = i.main.temp
            let date = i.dt
            let id = i.weather[0].id
            
            hour = ForecastWeatherModel(conditionId: getIconSystemName(by: id),
                                        date: getDateTime(date: Date(timeIntervalSince1970: date)),
                                        temp: tempPresenter(for: temp))
            hours.append(hour)
        }
        return hours
    }
    
    func tempPresenter (for temp: Double) -> String {
        return String("\(Int(temp))°C")
    }
    
    
    func getDateTime (date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: inputDate)
    }
    
    private func getIconSystemName(by id: Int) -> String {
        switch id {
        case 200...202, 230...232:
            return "cloud.bolt.rain"
        case 210...229:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...501:
            return "cloud.rain"
        case 502...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
