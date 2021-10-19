//
//  ViewModel.swift
//  daWeather
//
//  Created by Максим Хлесткин on 19.10.2021.
//

import Foundation
import CoreLocation

struct ViewModel {
    var dailyModel: DailyWeatherModel?
    var forecastModel: [ForecastWeatherModel]?
    var location: CLLocation?
    var additionalInfoModel: [AdditionalInfo]?
}
