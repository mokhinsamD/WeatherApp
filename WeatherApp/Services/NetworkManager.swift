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
    
    func fetchWeather(from url: String, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let weather = try decoder.decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

