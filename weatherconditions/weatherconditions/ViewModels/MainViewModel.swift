//
//  MainViewModel.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private var disposables: Set<AnyCancellable> = []

    private (set) var forecast: Forecast!
    private (set) var weatherIconData: Data!

    //TODO: Get parameter city name
    func fetch(city:String) {
        WeatherAPI.forecast(city: city)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    NotificationBanner.show("No data from the search")//TODO: parse the error 
                case .finished:
                    print("fetch data completed")
                }
            },
                  receiveValue: {
                    self.forecast = $0
                    if let currentWeather = $0.list.first, currentWeather.weather.count > 0 {
                        let weather = currentWeather.weather.first
                        self.fetchIcon(weather!.icon)
                    }else {
                        //TODO: Handle no data
                    }
                  })
            .store(in: &disposables)
       
    }
    
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
