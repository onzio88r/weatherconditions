//
//  APIAgent.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 29/10/2020.
//

import Foundation
import Combine

struct APIAgent {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func run(_ request: URLRequest) -> AnyPublisher<Response<Data>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<Data> in
                return Response(value: result.data, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
