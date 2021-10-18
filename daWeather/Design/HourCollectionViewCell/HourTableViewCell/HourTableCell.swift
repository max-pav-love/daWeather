//
//  HourTableCell.swift
//  daWeather
//
//  Created by Максим Хлесткин on 18.10.2021.
//

import UIKit

class HourTableCell: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collection.register(HourCell.nib(), forCellWithReuseIdentifier: HourCell.identifier)
    
        backgroundColor = .clear
    }
    
    static let identifier = "HourTableCell"
    
    static func nib () -> UINib {
        return UINib(nibName: "HourTableCell", bundle: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCell.identifier, for: indexPath) as! HourCell
        return cell
    }
    
}

extension HourTableCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
}
