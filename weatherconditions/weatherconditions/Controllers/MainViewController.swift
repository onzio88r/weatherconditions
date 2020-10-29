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
    
    private var disposables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherAPI.forecast(city: "Roma,it")
            .print()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { print($0) })
            .store(in: &disposables)
        

    }


}

