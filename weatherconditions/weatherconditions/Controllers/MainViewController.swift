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
    @IBOutlet weak var textFieldLeadingConstraint: NSLayoutConstraint!
    
    
    private var disposables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherAPI.forecast(city: "Roma,it")
            .print()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { print($0) })
            .store(in: &disposables)
        
        textFieldLeadingConstraint.constant = searchButton.frame.origin.x - 10
        self.textField.alpha = 0
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        //TODO: little animation for text field, review and move in specifi function
        textFieldLeadingConstraint.constant = 20
        self.textField.alpha = 1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .autoreverse, animations: {
            
            self.textField.layoutIfNeeded()
        }, completion: nil)
        
        
    
    }
    

}

