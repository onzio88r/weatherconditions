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


/// Transform the country code to the flag
/// - Parameter country: ISO country code
/// - Returns: Return a flag as String
func Flag(country:String) -> String {
    let base = 127397
    var usv = String.UnicodeScalarView()
    for i in country.utf16 {
        usv.append(UnicodeScalar(base + Int(i))!)
    }
    return String(usv)
}
