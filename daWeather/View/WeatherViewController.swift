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
    
    @IBOutlet private weak var collection: UICollectionView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    @IBOutlet private weak var cellTitleLabel: UILabel?
    @IBOutlet private weak var cellImageView: UIImageView?
    @IBOutlet private weak var cellDetailLabel: UILabel?
    
    var networkManager = Network()
    var locationManager = CLLocationManager()
    var mapper = Mapper()
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTemperatureLable?.textColor = .gray
        hideElements()
        
        collection?.register(HourCell.nib(), forCellWithReuseIdentifier: HourCell.identifier)
        
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
        
        cellDetailLabel?.text = "\(weather.description)"
        
        showElements()
    }
    
    func didUpdateForecast(weather: [ForecastWeatherModel]) {
        
    }
    
    // MARK: - Configure UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCell", for: indexPath) as! HourCell
        return cell
    }
    
    // MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feelsLike", for: indexPath)
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
        cityLabel?.isHidden = true
        mainDescriptionLabel?.isHidden = true
        mainWeatherIcon?.isHidden = true
        minMaxLabel?.isHidden = true
        collection?.isHidden = true
    }
    
    func showElements() {
        activityIndicator?.stopAnimating()
        cityLabel?.isHidden = false
        mainDescriptionLabel?.isHidden = false
        mainWeatherIcon?.isHidden = false
        minMaxLabel?.isHidden = false
        mainTemperatureLable?.textColor = .black
        collection?.isHidden = false
    }
}

//MARK: - Extensions

extension WeatherViewController: WeatherManagerDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
}

