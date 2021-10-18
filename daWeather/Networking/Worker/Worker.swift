//
//  Worker.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation
import Alamofire

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: DailyWeatherModel)
    func didUpdateForecast(weather: [ForecastWeatherModel])
}

final class Network {
    
    var delegate: WeatherManagerDelegate?
    
    private let mapper = Mapper()
    
    // MARK: - Put coordinates in URL
    
    func fetchLocationForUrl (lon: Double, lat: Double) {
        let locatedDailyUrl = dailyUrl + "&lon=\(lon)&lat=\(lat)"
        let locatedForecastUrl = forecastUrl + "&lon=\(lon)&lat=\(lat)"
        makeRequest(url: locatedDailyUrl)
        makeForecastRequest(url: locatedForecastUrl)
    }
    
    // MARK: - Make weather request
    
    func makeRequest (url: String) {
        AF.request(url).responseDecodable(of: DailyWeather.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                if let viewModel = self?.mapper.mapDay(weather: value) {
                    self?.delegate?.didUpdateWeather(weather: viewModel)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func makeForecastRequest (url: String) {
        AF.request(url).responseDecodable(of: Forecast.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                if let viewModel = self?.mapper.map(weather: value) {
                    self?.delegate?.didUpdateForecast(weather: viewModel)
                    print(viewModel)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
