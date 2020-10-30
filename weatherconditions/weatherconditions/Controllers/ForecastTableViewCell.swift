//
//  ForecastTableViewCell.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeLabel.text = ""
        tempLabel.text = ""
        mainLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func bindViewModel(model: List){
        
        if let weather = model.weather.first {
            mainLabel.text = weather.main
            descriptionLabel.text = weather.description
        }
        
        let main = model.main
        tempLabel.text = "\(main.temp)º"
        timeLabel.text =  millisecondsToLocalDate(model.dt)
        
        //TODO: download image and set it 
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
