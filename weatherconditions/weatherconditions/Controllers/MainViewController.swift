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
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    let viewModel =  MainViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewData()
        bindViewModel()
        
        viewModel.fetch()
        
        
    }
    
    private func initViewData(){
        cityName.text               = ""
        weatherConditionLabel.text  = ""
        sunriseLabel.text           = ""
        sunsetLabel.text            = ""
        
    }
    
    private func bindViewModel() {
        viewModel.objectWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            self.rederForecast(self.viewModel.forecast)
        }.store(in: &cancellables)
    }
    
    private func rederForecast(_ forecast:Forecast){
        self.cityName.text      = forecast.city.name
        
        self.sunriseLabel.text  = millisecondsToLocalDate(forecast.city.sunrise)
        self.sunsetLabel.text   = millisecondsToLocalDate(forecast.city.sunset)
        
      
        let image = UIImage(data: viewModel.weatherIconData)
        weatherImage.image = image
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        
    }
    
    
}

