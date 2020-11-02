//
//  ViewController.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 28/10/2020.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    // MARK: - Outlets
    
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
    
    // MARK: - Variables
    let viewModel =  MainViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    var forecastTableController: ForecastTableViewController!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.1).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor,
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
}

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        gradient.frame = view.bounds
        opacityView.layer.addSublayer(gradient)
        
        
        dayNightView()
        initViewData()
        bindViewModel()
                
        self.textField.delegate = self
        
    }
    // MARK: - Init labels
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
    
    // MARK: - Model render
    private func bindViewModel() {
        viewModel.objectWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            
            self.rederForecast(self.viewModel.forecast)
            
            self.forecastTableController.listModel = self.viewModel.forecast.list
        }.store(in: &cancellables)
    }
    
    private func dayNightView(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour < 13 {
            backgroundImage.image = UIImage(named: "Day-\(hour/2)")
        }else {
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
            
        }
    }
    
    
    
    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ForecastTableViewController {
            self.forecastTableController = (segue.destination as! ForecastTableViewController)
        }
    }
    
    
}

//MARK: - Delegate 
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.viewModel.fetch(city: textField.text!)
        self.view.endEditing(true)
        return true
    }
}
