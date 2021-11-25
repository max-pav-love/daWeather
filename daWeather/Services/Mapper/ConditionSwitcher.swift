//
//  ConditionSwitcher.swift
//  daWeather
//
//  Created by Максим Хлесткин on 20.10.2021.
//

import Foundation

func getIconSystemName(by id: Int) -> String {
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
        return ""
    }
}
