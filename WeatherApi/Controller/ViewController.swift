//
//  ViewController.swift
//  WeatherApi
//
//  Created by Ержан Джанарстанов on 22.05.2022.
//

import UIKit

final class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tempatureLabel: UILabel!
    @IBOutlet private weak var imageViewBackgound: UIImageView!
    @IBOutlet private weak var gradusLabel: UILabel!
    
    private var  manager = WeatherManager()
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        gradusLabel.isHidden = true
        manager.delegate = self
        imageViewBackgound.image = UIImage(named: "trees")
    }

//MARK: - Actions
    @IBAction private func tappedButton(_ sender: UIButton) {
        manager.fetchWeather(with: textField.text!)
        gradusLabel.isHidden = false
    }
}
//MARK: - Delegate
extension ViewController: WeatherManagerDelegate {
func onWeatherModelDidUpdate(with model: WeatherModel) {
    cityLabel.text = model.name
    tempatureLabel.text = String(format: "%.1f", model.main.temp)
    imageView.image = UIImage(systemName: model.weather[0].conditionId)
}
}
