//
//  Mapper.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation
import Alamofire

final class Mapper {
    
    //MARK: - Map main data
    
    func mapDay(weather: DailyWeather) -> DailyWeatherModel {
        DailyWeatherModel(cityName: weather.name,
                          temperature: tempPresenter(for:weather.main.temp),
                          description: weather.weather[0].description.capitalizingFirstLetter(),
                          maxTemp: tempPresenter(for: weather.main.temp_max),
                          minTemp: tempPresenter(for: weather.main.temp_min),
                          feelsLike: weather.main.feels_like,
                          humidity: weather.main.humidity,
                          id: getIconSystemName(by: weather.weather[0].id),
                          visibility: weather.visibility,
                          pressure: weather.main.pressure,
                          windSpeed: weather.wind.speed)
    }
    
    // MARK: - Map forecast data
    
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
    
    // MARK: - Map additional data
    
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
}
