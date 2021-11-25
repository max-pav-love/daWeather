//
//  ViewController.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation
import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet private weak var backgroundImage: UIImageView?
    @IBOutlet private weak var table: UITableView?
    
    private var additionalInfo: [AdditionalInfo] = []
    private var networkManager = Network()
    private var locationManager = CLLocationManager()
    private var viewModel = ViewModel()
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        hideElements()
        table?.sectionHeaderTopPadding = 0
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        networkManager.delegate = self
    }
    
    // MARK: - Network Manager Delegates
    
    func didUpdateWeather(weather: DailyWeatherModel) {
        viewModel.dailyModel = weather
        table?.reloadData()
    }
    
    func didUpdateForecast(weather: [ForecastWeatherModel]) {
        viewModel.forecastModel = weather
        table?.reloadData()
    }
    
    func didUpdateAdditionalInfo(weather: [AdditionalInfo]) {
        additionalInfo = weather
        table?.reloadData()
        showElements()
    }
    
    // MARK: - UITableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightForHeader(in: section, tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        heightForFooter(in: section, tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        registerCells(with: indexPath, tableView)
    }
    
    // MARK: - Location Manager Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            viewModel.location = location
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            networkManager.fetchLocationForUrl(lon: lon, lat: lat)
            locationManager.stopUpdatingLocation()
            print("\(lon),\(lat)")
            table?.reloadData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .notDetermined:
            break
        default:
            print("error")
            fatalError()
        }
    }
    
    // MARK: - UIAlert Methods
    
    func showRetryAlert(error: String) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: error,
                                      preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Повторить", style: .default) { [self] _ in
            guard
                let lon = self.viewModel.location?.coordinate.longitude,
                let lat = self.viewModel.location?.coordinate.latitude
            else {
                return
            }
            self.networkManager.fetchLocationForUrl(lon: lon, lat: lat)
        }
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private func numberOfRows(in section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return additionalInfo.count
    }
    
    private func numberOfSections() -> Int {
        3
    }
    
    private func heightForRow(at indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 370
        } else if indexPath.section == 1 {
            return 128
        }
        return 60
    }
    
    private func heightForHeader(in section: Int, _ tableView: UITableView) -> CGFloat {
        if section == 2 {
            return .leastNonzeroMagnitude
        }
        return tableView.sectionHeaderHeight
    }
    
    private func heightForFooter(in section: Int, _ tableView: UITableView) -> CGFloat {
        if section == 0 {
            return .leastNonzeroMagnitude
        }
        return tableView.sectionHeaderHeight
    }
    
    private func registerCells(with indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            guard
                let mainCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
                    return UITableViewCell()
                }
            mainCell.configureMain(data: viewModel.dailyModel)
            return mainCell
        }
        else if indexPath.section == 1 {
            guard
                let collectionCell = tableView.dequeueReusableCell(withIdentifier: HourTableCell.identifier, for: indexPath) as? HourTableCell else {
                    return UITableViewCell()
                }
            collectionCell.configureCell(with: viewModel.forecastModel)
            return collectionCell
        }
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalCell.identifier, for: indexPath) as? AdditionalCell else {
                return UITableViewCell()
            }
        cell.configure(data: (additionalInfo[indexPath.row]))
        return cell
    }
    
    private func registerCells() {
        table?.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifier)
        table?.register(HourTableCell.nib(), forCellReuseIdentifier: HourTableCell.identifier)
        table?.register(AdditionalCell.nib(), forCellReuseIdentifier: AdditionalCell.identifier)
    }
    
    // MARK: - UI Methods
    
    func hideElements() {
        table?.isHidden = true
    }
    
    func showElements() {
        activityIndicator?.stopAnimating()
        table?.isHidden = false
        backgroundImage?.isHidden = false
    }
    
}

//MARK: - Extensions

extension WeatherViewController: WeatherManagerDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
}

