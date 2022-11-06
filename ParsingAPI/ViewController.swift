//
//  ViewController.swift
//  ParsingAPI
//
//  Created by Дарина Самохина on 06.11.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
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
            do {
                let weather = try decoder.decode(Weather.self, from: data)
                print(weather)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    
    
    
}

