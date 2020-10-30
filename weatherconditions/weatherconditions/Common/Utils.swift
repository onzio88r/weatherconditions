//
//  Utils.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import Foundation


func millisecondsToLocalDate(_ milliseconds: Int) -> String{
    
    let date = Date(timeIntervalSince1970: TimeInterval(milliseconds))
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.locale = Locale.current
    
    return dateFormatter.string(from: date)
    
}