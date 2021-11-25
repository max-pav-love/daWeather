//
//  DataPresenters.swift
//  daWeather
//
//  Created by Максим Хлесткин on 20.10.2021.
//

import Foundation

// MARK: - Converters

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
    guard let inputDate = date else { return "" }
    let formatter = DateFormatter()
    formatter.dateFormat = "HH"
    return formatter.string(from: inputDate)
}
