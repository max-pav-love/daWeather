//
//  Mapper.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation

final class Mapper {
    func mapDay(weather: DailyWeather) -> DailyWeatherModel {
        DailyWeatherModel(cityName: weather.name,
                          temperature: tempPresenter(for:weather.main.temp),
                          description: weather.weather[0].description.capitalizingFirstLetter(),
                          maxTemp: tempPresenter(for: weather.main.temp_max),
                          minTemp: tempPresenter(for: weather.main.temp_min),
                          feelsLike: weather.main.feels_like,
                          humidity: weather.main.humidity,
                          id: getIconSystemName(by: weather.id),
                          visibility: weather.visibility,
                          pressure: weather.main.pressure,
                          windSpeed: weather.wind.speed)
    }
    
    func map(weather: Forecast) -> [ForecastWeatherModel] {
        var hours: [ForecastWeatherModel] = []
        
        for i in weather.list {
            if hours.count >= 8 {
                return hours
            }
            let temp = i.main.temp
            let date = i.dt
            let id = i.weather[0].id
            
            let hour = ForecastWeatherModel(conditionId: getIconSystemName(by: id),
                                            date: getDateTime(date: Date(timeIntervalSince1970: date)),
                                            temp: tempPresenter(for: temp))
            hours.append(hour)
        }
        return hours
    }
    func mapInfo(weather: DailyWeatherModel) -> [AdditionalInfo] {
        let additonal: [AdditionalInfo] = [AdditionalInfo(icon: "staroflife",
                                                          title: "Ощущается как",
                                                          description: "\(Int(weather.feelsLike))"+"°C"),
                                           AdditionalInfo(icon: "wind",
                                                          title: "Скорость ветра",
                                                          description: getWindSpeed(for: weather.windSpeed)),
                                           AdditionalInfo(icon: "drop",
                                                          title: "Влажность",
                                                          description: getHumidity(for: weather.humidity)),
                                           AdditionalInfo(icon: "thermometer",
                                                          title: "Давление",
                                                          description: getPressure(for: weather.pressure)),
                                           AdditionalInfo(icon: "eye",
                                                          title: "Видимость",
                                                          description: getVisibility(for: weather.visibility))]
        return additonal
    }
    
    func tempPresenter (for temp: Double) -> String {
        return String("\(Int(temp))°C")
    }
    
    func getHumidity(for humidity: Double) -> String {
        return String("\(Int(humidity)) %")
    }
    
    func getPressure(for pressure: Int) -> String {
        return String("\(Int((Double(exactly: pressure)! / 1.333)))" + " мм")
    }
    
    func getVisibility(for visibility: Int ) -> String {
        return String("\(Int(exactly: visibility)! / 1000)"+" км")
    }
    func getWindSpeed(for wind: Double) -> String {
        return String ("\(wind.truncate(places: 1))" + " м/с")
    }
    
    func getDateTime (date: Date?) -> String {
        guard
            let inputDate = date
        else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: inputDate)
    }
    
    private func getIconSystemName(by id: Int) -> String {
        switch id {
        case 200...202, 230...232:
            return "cloud.bolt.rain.fill"
        case 210...229:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...501:
            return "cloud.rain.fill"
        case 502...531:
            return "cloud.heavyrain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.bolt.fill"
        default:
            return "cloud.fill"
        }
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
