//
//  WeatherViewModel.swift
//  WeatherApi
//
//  Created by Ержан Джанарстанов on 28.05.2022.
//

import Foundation
import UIKit

struct WeatherViewModel {
    let conditionId: Int
    let tempText: String
    var weatherImageName: String {
        switch conditionId {
        case 200...300:
            return ""
        default:
            return ""
        }
    }
    var weatherImage: UIImage {
        return UIImage(named: weatherImageName)!
    }
    
    init(weatherModel: WeatherModel) {
        self.conditionId = weatherModel.weather[0].id
        self.tempText = String(format: "%.2f", weatherModel.main.temp)
    }
}
