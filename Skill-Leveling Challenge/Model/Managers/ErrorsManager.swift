//
//  ErrorsManager.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 22-09-22.
//

import Foundation
import UIKit

class ErrorsManager {
    static let shared = ErrorsManager()
    private init() {}
    
    func showErrorAlert(message: String, vc: UIViewController) {
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
            vc.present(errorAlert, animated: true, completion: nil)
        }
    }
}
