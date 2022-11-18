//
//  ViewController+.swift
//  AppCarros
//
//  Created by Igor Fernandes on 17/11/22.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String?, completion: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true)
            completion()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}
