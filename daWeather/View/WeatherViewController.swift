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
    
    @IBOutlet private weak var cityLabel: UILabel?
    @IBOutlet private weak var mainTemperatureLable: UILabel?
    @IBOutlet private weak var mainDescriptionLabel: UILabel?
    @IBOutlet private weak var mainWeatherIcon: UIImageView?
    @IBOutlet private weak var minMaxLabel: UILabel?
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var table: UITableView!
    
    var networkManager = Network()
    var locationManager = CLLocationManager()
    var mapper = Mapper()
    
    let additonal: [AdditionalInfo] = [AdditionalInfo(icon: "staroflife", title: "Ощущается как", description: "+14°C"), AdditionalInfo(icon: "wind", title: "Скорость ветра", description: "13 м/с"), AdditionalInfo(icon: "eye", title: "Видимость", description: "14 км")]
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTemperatureLable?.textColor = .gray
        hideElements()
        
        table.register(HourTableCell.nib(), forCellReuseIdentifier: HourTableCell.identifier)
        table.register(AdditionalCell.nib(), forCellReuseIdentifier: AdditionalCell.identifier)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        networkManager.delegate = self
        
    }
    
    // MARK: - Network Manager Delegates
    
    func didUpdateWeather(weather: DailyWeatherModel) {
        cityLabel?.text = weather.cityName
        mainTemperatureLable?.text = weather.temperature.description
        mainDescriptionLabel?.text = weather.description
        mainWeatherIcon?.image = UIImage(systemName: weather.id)
        minMaxLabel?.text = weather.minMaxTemp
        showElements()
    }
    
    func didUpdateForecast(weather: [ForecastWeatherModel]) {
        
    }
    
    // MARK: - Configure UICollectionView
    
    
    // MARK: - UITableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return additonal.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        }
        return 60
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let collectionCell = tableView.dequeueReusableCell(withIdentifier: HourTableCell.identifier, for: indexPath) as! HourTableCell
            return collectionCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalCell.identifier, for: indexPath) as! AdditionalCell
        cell.configure(data: additonal[indexPath.row])
        return cell
    }
    
    // MARK: - Location Manager Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            networkManager.fetchLocationForUrl(lon: lon, lat: lat)
            locationManager.stopUpdatingLocation()
            print("\(lon),\(lat)")
            table.reloadData()

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
    
    func hideElements() {
        table.isHidden = true
        table.backgroundColor = .clear
        cityLabel?.isHidden = true
        mainDescriptionLabel?.isHidden = true
        mainWeatherIcon?.isHidden = true
        minMaxLabel?.isHidden = true
        backgroundImage.isHidden = true
    }
    
    func showElements() {
        activityIndicator?.stopAnimating()
        cityLabel?.isHidden = false
        mainDescriptionLabel?.isHidden = false
        mainWeatherIcon?.isHidden = false
        minMaxLabel?.isHidden = false
        mainTemperatureLable?.textColor = .black
        table.isHidden = false
        backgroundImage.isHidden = false
    }
}

//MARK: - Extensions

extension WeatherViewController: WeatherManagerDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
}

