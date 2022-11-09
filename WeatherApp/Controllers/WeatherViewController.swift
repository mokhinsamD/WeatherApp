//
//  WeatherViewController.swift
//  ParsingAPI
//
//  Created by Дарина Самохина on 06.11.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var degreeLabel: UILabel!
    @IBOutlet var spedWindLabel: UILabel!
    
    private let url = "https://api.weatherapi.com/v1/current.json?key=d1b6e7d23c7d433eb1a95416220611&q=moscow"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }
    
}

extension WeatherViewController {
    private func fetchWeather() {
        NetworkManager.shared.fetchWeather(from: url) { [unowned self] result in
            switch result {
            case .success(let weather):
                cityNameLabel.text = weather.location.name
                degreeLabel.text = String(weather.current.tempC)
                spedWindLabel.text = String(weather.current.windMph)
                guard let imageURL = URL(string: "https:\(weather.current.condition.icon)") else { return }
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imageURL) else {
                        return
                    }
                    DispatchQueue.main.async { [unowned self] in
                        imageView.image = UIImage(data: imageData)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
