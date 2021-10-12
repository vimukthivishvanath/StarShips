//
//  AlertDisplayer.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 10/10/21.
//

import Foundation
import UIKit

enum AlertType {
    case successful
    case error
    case faliure
}
protocol AlertDisplayer {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
    func displaySingleActionAlert(with type: AlertType, message: String)
}

extension AlertDisplayer where Self: UIViewController {
    
    func getTitle(type:AlertType)-> String{
        
        switch type {
        case .successful:
            return "SUCCESS".localizedString()
        case .error:
            return "ERROR".localizedString()
        case .faliure:
            return "FAILURE".localizedString()
        }
    }
    
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
    
    func displaySingleActionAlert(with type: AlertType, message: String) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: getTitle(type: type), message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localizedString(), style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

