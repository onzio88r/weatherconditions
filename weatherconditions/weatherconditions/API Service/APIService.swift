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
    
    static func weatherIcon(icon: String) -> AnyPublisher<Data, Error> {
        let baseUrlIcon = URL(string: String(format: weatherIConURL, icon))!
        
        let request = URLRequest(url: baseUrlIcon)
           return run(request)
       }
    
    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
            return agent.run(request)
                .map(\.value)
                .eraseToAnyPublisher()
        }
    
    static func run(_ request: URLRequest) -> AnyPublisher<Data, Error> {
            return agent.run(request)
                .map(\.value)
                .eraseToAnyPublisher()
        }
    
    
}

