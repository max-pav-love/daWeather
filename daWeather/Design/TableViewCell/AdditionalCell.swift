//
//  AdditionalCell.swift
//  daWeather
//
//  Created by Максим Хлесткин on 18.10.2021.
//

import UIKit

class AdditionalCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    static let identifier = "AdditionalCell"
    
    static func nib () -> UINib {
        return UINib(nibName: "AdditionalCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: AdditionalInfo) {
            self.cellDescription.text = data.description
            self.cellImage.image = UIImage(systemName: data.icon)
            self.cellTitle.text = data.title
    }

}
