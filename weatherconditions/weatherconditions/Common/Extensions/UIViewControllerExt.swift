//
//  UIViewEXT.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Hide the keyboard when tap on virew it's detected
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
