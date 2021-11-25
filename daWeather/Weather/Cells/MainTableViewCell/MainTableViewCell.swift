//
//  MainTableViewCell.swift
//  daWeather
//
//  Created by Максим Хлесткин on 19.10.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cityLabel: UILabel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var currentTempLabel: UILabel?
    @IBOutlet private weak var minMaxLabel: UILabel?
    @IBOutlet private weak var conditionIcon: UIImageView?
    
    static let identifier = "MainTableViewCell"
    
    static func nib () -> UINib {
        return UINib(nibName: "MainTableViewCell", bundle: nil)
    }
    
    func configureMain(data: DailyWeatherModel?) {
        self.descriptionLabel?.text = data?.description
        self.currentTempLabel?.text = data?.temperature
        self.conditionIcon?.image = UIImage(systemName: data?.id ?? "")
        self.cityLabel?.text = data?.cityName
        self.minMaxLabel?.text = data?.minMaxTemp
    }
    
}
