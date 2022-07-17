//
//  WeatherManager.swift
//  WeatherApi
//
//  Created by Ержан Джанарстанов on 22.05.2022.
//

import Foundation

//MARK: - Delegate
protocol WeatherManagerDelegate: AnyObject {
    func onWeatherModelDidUpdate(with model: WeatherModel)

}
//MARK: - URlSession
struct WeatherManager {
    
    weak var delegate: WeatherManagerDelegate?
    
   private let urlString =
    "https://api.openweathermap.org/data/2.5/weather?appid=65870ff1c49d3a93c2e73ffcea6698db&units=metric&q="
   
    func fetchWeather(with cityName: String){
        guard let formatedUrl = URL(string: urlString + cityName) else { return }
        let urlRequest = URLRequest(url: formatedUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
            } else {
                guard let safeData = data else { return }
                parseJsonWeather(from: safeData)
                print(safeData)
            }
        }
        task.resume()
    }
    
   private func parseJsonWeather(from data: Data) {
        let decoder = JSONDecoder()
        do {
            let decocedData = try decoder.decode(WeatherModel.self, from: data)
            DispatchQueue.main.async {
                delegate?.onWeatherModelDidUpdate(with: decocedData)
                print(decocedData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
