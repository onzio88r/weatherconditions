//
//  ViewController.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 28/10/2020.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var opacityView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var flag: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    let viewModel =  MainViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        dayNightView()
        initViewData()
        bindViewModel()
        
        viewModel.fetch(city: "Roma")
        
        self.textField.delegate = self
        
        
    }
    
    private func initViewData(){
        cityName.text               = ""
        weatherConditionLabel.text  = ""
        sunriseLabel.text           = ""
        sunsetLabel.text            = ""
        temperatureLabel.text       = ""
        minTempLabel.text           = ""
        maxTempLabel.text           = ""
        flag.text                   = ""
        
    }
    
    private func bindViewModel() {
        viewModel.objectWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            self.rederForecast(self.viewModel.forecast)
        }.store(in: &cancellables)
    }
    
    private func dayNightView(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour < 13 {
            opacityView.isHidden = false
            backgroundImage.image = UIImage(named: "Day-\(hour/2)")
        }else {
            opacityView.isHidden = true
            backgroundImage.image = UIImage(named: "Night-\((hour-12)/2)")
        }
    }
    
    private func rederForecast(_ forecast:Forecast){
        self.cityName.text      = forecast.city.name
        
        if let currentWeather = forecast.list.first, currentWeather.weather.count > 0 {
        
        self.weatherConditionLabel.text = currentWeather.weather.first!.description
        
        self.sunriseLabel.text  = millisecondsToLocalDate(forecast.city.sunrise)
        self.sunsetLabel.text   = millisecondsToLocalDate(forecast.city.sunset)
        
      
        let image = UIImage(data: viewModel.weatherIconData)
        weatherImage.image = image
        
        
        // Weather temperature value to label
        let weatherModel = currentWeather.main
        if String(weatherModel.temp) != "" {
            self.temperatureLabel.text = "\(String(Int(weatherModel.temp)))º"
        }
        if String(weatherModel.temp_min) != "" {
            self.minTempLabel.text = "\(String(weatherModel.temp_min))º"
        }
        if String(weatherModel.temp_max) != "" {
            self.maxTempLabel.text = "\(String(weatherModel.temp_max))º"
        }
            
        flag.text = Flag(country: forecast.city.country)
        
        }else {
            //TODO Handle no data
        }
    }
    

    
    
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.viewModel.fetch(city: textField.text!)
        self.view.endEditing(true)
        return true
    }
}
