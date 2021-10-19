//
//  HourTableCell.swift
//  daWeather
//
//  Created by Максим Хлесткин on 18.10.2021.
//

import UIKit

class HourTableCell: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    
    var viewModel: [ForecastWeatherModel] = []
    static let identifier = "HourTableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collection.register(HourCell.nib(), forCellWithReuseIdentifier: HourCell.identifier)
    }
    
    static func nib () -> UINib {
        return UINib(nibName: "HourTableCell", bundle: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCell.identifier, for: indexPath) as! HourCell
        cell.configureCell(with: viewModel[indexPath.row])
        return cell
    }
    
    func configureCell(with hours: [ForecastWeatherModel]?) {
        viewModel = hours ?? []
        collection.reloadData()
    }
    
}

extension HourTableCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
}
