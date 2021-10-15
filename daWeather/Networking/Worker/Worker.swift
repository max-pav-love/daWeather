//
//  Worker.swift
//  daWeather
//
//  Created by Максим Хлесткин on 15.10.2021.
//

import Foundation
import Alamofire

func makeRequest () {
    AF.request(dailyUrl).responseDecodable(of: DailyWeather.self) { response in
        switch response.result {
        case .success(let value):
            print(value)
        case .failure(let error):
            print(error)
        }
    }
}
