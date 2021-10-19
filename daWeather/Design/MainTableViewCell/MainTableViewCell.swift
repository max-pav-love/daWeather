//
//  MainTableViewCell.swift
//  daWeather
//
//  Created by Максим Хлесткин on 19.10.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    
    static let identifier = "MainTableViewCell"
    
    static func nib () -> UINib {
        return UINib(nibName: "MainTableViewCell", bundle: nil)
    }
    
    func configureMain(data: DailyWeatherModel?) {
        self.descriptionLabel.text = data?.description
        self.currentTempLabel.text = data?.temperature
        self.conditionIcon.image = UIImage(systemName: data?.id ?? "cloud.fill")
        self.cityLabel.text = data?.cityName
        self.minMaxLabel.text = data?.minMaxTemp
    }
}
