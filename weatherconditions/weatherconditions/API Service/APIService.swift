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
    
    static func urlComponentFrom(city: String) -> URLComponents{
        var component = URLComponents()
        component.scheme = "http"
        component.path = forecastAPIPath
        component.host = openweatherURL
        component.queryItems = [
            
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: "e53a70fab51d98c3061bff74b4c4b010")]
        
        return component
    }
    
}

extension WeatherAPI {
    
    static func forecast(city: String) -> AnyPublisher<Forecast, Error> {
        let urlComponent = WeatherAPI.urlComponentFrom(city: city)
        let request = URLRequest(url: urlComponent.url!)
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
