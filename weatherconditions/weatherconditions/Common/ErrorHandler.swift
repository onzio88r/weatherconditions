//
//  ErrorHandler.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import Foundation

public enum ErrorHandler: Error {
    case statusCode(String)
    case NoData
    case other(Error)
    
    static func map(_ error: Error) -> ErrorHandler {
        return (error as? ErrorHandler) ?? .other(error)
    }
}

struct ErrorStruct: Codable {
    let cod: String
    let message: String
}
