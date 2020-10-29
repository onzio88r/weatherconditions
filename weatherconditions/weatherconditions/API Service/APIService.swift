//
//  APIService.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 28/10/2020.
//

import Foundation
import Combine

enum WeatherAPI {
    static let agent = APIAgent()
    static var baseUrl = URL(string: openweatherURL)!
}

extension WeatherAPI {
    
    static func forecast(city: String) -> AnyPublisher<Forecast, Error> {
         
        let request = URLRequest(url: baseUrl) //TODO: Add parameters for selected city
           return run(request)
       }
    
    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
            return agent.run(request)
                .map(\.value)
                .eraseToAnyPublisher()
        }
}


struct Forecast: Codable {
    let city: City
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    //TODO: TO be completed
    
    
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}
