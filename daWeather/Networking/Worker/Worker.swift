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
    func showRetryAlert(error: String)
    func didUpdateAdditionalInfo(weather: [AdditionalInfo])
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
                if let mainViewModel = self?.mapper.mapDay(weather: value),
                   let infoViewModel = self?.mapper.mapInfo(weather: mainViewModel) {
                    self?.delegate?.didUpdateWeather(weather: mainViewModel)
                self?.delegate?.didUpdateAdditionalInfo(weather: infoViewModel)
            }
            case .failure(let error):
                self?.delegate?.showRetryAlert(error: error.localizedDescription)
            }
        }
    }
    
    func makeForecastRequest (url: String) {
        AF.request(url).responseDecodable(of: Forecast.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                if let viewModel = self?.mapper.map(weather: value) {
                    self?.delegate?.didUpdateForecast(weather: viewModel)
                }
            case .failure(let error):
                self?.delegate?.showRetryAlert(error: error.localizedDescription)
            }
        }
    }
    
}
