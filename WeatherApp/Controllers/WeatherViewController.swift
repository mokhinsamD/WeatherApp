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
        fetchImage()
    }
    
    private func fetchWeather() {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=d1b6e7d23c7d433eb1a95416220611&q=moscow") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let weather = try decoder.decode(Weather.self, from: data)
                DispatchQueue.main.async { [unowned self] in
                    cityNameLabel.text = weather.location.name
                    degreeLabel.text = String(weather.current.tempC)
                    spedWindLabel.text = String(weather.current.windMph)
                    imageView.image = UIImage(named: "https://\(weather.current.condition.icon)")
                }
                print(weather)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: "https://cdn.weatherapi.com/weather/64x64/day/296.png") { [unowned self] result in
            switch result {
            case .success(let imageData):
                imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

