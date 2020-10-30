//
//  ForecastModel.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import Foundation

struct Forecast: Codable {
    let city: City
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let sunrise: Int
    let sunset: Int
    //TODO: TO be completed
    
    
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}
