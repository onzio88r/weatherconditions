//
//  ForecastTableViewCell.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import UIKit
import Combine

class ForecastTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Variables

    let viewModel = ForecastCellViewModel()
    
    private var cancellables: Set<AnyCancellable> = []

}

extension ForecastTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
        
        viewModel.objectWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            
            self.renderIconWeather()
        }.store(in: &cancellables)
    }
    
    private func commonInit() {
        timeLabel.text = ""
        tempLabel.text = ""
        mainLabel.text = ""
        descriptionLabel.text = ""
        dayLabel.text = ""
    }
    
    // MARK: - Model
    
    func bindCellData(model: List){
        
        if let weather = model.weather.first {
            mainLabel.text = weather.main
            descriptionLabel.text = weather.description
            
            //fetch icon
            viewModel.fetchIcon(weather.icon)

        }
        
        let main = model.main
        tempLabel.text = "\(main.temp)º"
        timeLabel.text =  millisecondsToLocalDate(model.dt)
        
        showOrHideDay(dt: model.dt)
    }
    
    private func showOrHideDay(dt: Int) {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale.current
        
        let calanderDate = Calendar.current.dateComponents([.hour], from: date)
        
        if calanderDate.hour! == 1 {
            dayLabel.text = dateFormatter.string(from: date)
        }else {
            dayLabel.text = ""
        }
    }
    
    private func renderIconWeather(){
        let image = UIImage(data: viewModel.weatherIconData)
        weatherImage.image = image
    }

}
