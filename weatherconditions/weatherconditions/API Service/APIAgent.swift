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
                
                guard
                    // Check for a response error
                    let httpURLResponse = result.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                    else {
                    let error = try decoder.decode(ErrorStruct.self, from: result.data)
                    throw ErrorHandler.statusCode(error.message)
                    }
                
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .mapError{ ErrorHandler.map($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func run(_ request: URLRequest) -> AnyPublisher<Response<Data>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<Data> in
                guard
                    // Check for a response error
                    let httpURLResponse = result.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                    else {
                        
                    // return the status code error if exist
                        throw ErrorHandler.statusCode(String(data: result.data, encoding: .utf8)!)
                }
                
                return Response(value: result.data, response: result.response)
            }
            .mapError{ ErrorHandler.map($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
