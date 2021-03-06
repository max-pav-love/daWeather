//
//  InfoCell.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import UIKit

class HourCell: UICollectionViewCell {

    static let identifier = "HourCell"
    static func nib () -> UINib {
        return UINib(nibName: "HourCell", bundle: nil)
    }
    
    @IBOutlet private weak var timeLabel: UILabel?
    @IBOutlet private weak var tempLabel: UILabel?
    @IBOutlet private weak var weatherIcon: UIImageView?
    
    func configureCell(with hour: ForecastWeatherModel?) {
        self.timeLabel?.text = "\(hour!.date + ":00")"
        self.tempLabel?.text = hour?.temp
        self.weatherIcon?.image = UIImage(systemName: hour?.conditionId ?? "cloud.fill")
    }

}
