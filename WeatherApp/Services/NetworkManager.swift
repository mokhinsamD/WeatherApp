//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Дарина Самохина on 09.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
            
        }
    }
    
}
    
//    func fetchWeather() {
//        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=d1b6e7d23c7d433eb1a95416220611&q=moscow") else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            do {
//                let weather = try decoder.decode(Weather.self, from: data)
//                DispatchQueue.main.async { [unowned self] in
//                    cityNameLabel.text = weather.location.name
//                    degreeLabel.text = String(weather.current.tempC)
//                    spedWindLabel.text = String(weather.current.windMph)
//                    imageView.image = UIImage(named: "https://\(weather.current.condition.icon)")
//                }
//                print(weather)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//}

