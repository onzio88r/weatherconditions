//
//  ForecastTableViewModel.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import Foundation
import Combine

class ForecastCellViewModel: ObservableObject {
    private var disposables = Set<AnyCancellable>()
    private (set) var weatherIconData: Data!
}
extension ForecastCellViewModel {
    //MARK: - Fetch icon
    func fetchIcon(_ icon:String){
        WeatherAPI.weatherIcon(icon: icon)
            .sink(receiveCompletion: {_ in },
                  receiveValue: {
                    self.weatherIconData = $0
                    self.objectWillChange.send()
                  })
            .store(in: &disposables)
        
    }
    
}
