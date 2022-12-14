//
//  Weather.swift
//  ParsingAPI
//
//  Created by Дарина Самохина on 06.11.2022.
//

struct Weather: Decodable {
    let location: Location
    let current: Current
}

struct Location: Decodable {
    let name: String
}

struct Current: Decodable {
    let tempC: Double
    let windMph: Double
    let condition: Condition
}

struct Condition: Decodable {
    let icon: String
}
