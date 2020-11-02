//
//  ForecastModel.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import Foundation

struct Forecast: Codable {
    let city: City
    let list: [List]
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let sunrise: Int
    let sunset: Int
    
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
