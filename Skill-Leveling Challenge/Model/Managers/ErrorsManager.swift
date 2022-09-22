//
//  ErrorsManager.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 22-09-22.
//

import Foundation
import UIKit

// MARK: Errors Manager
class ErrorsManager {
    static let shared = ErrorsManager()
    private init() {}
    
    // Present alert with error message on ViewController
    func showErrorAlert(message: String, vc: UIViewController) {
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
            vc.present(errorAlert, animated: true, completion: nil)
        }
    }
}
