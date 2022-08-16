//
//  File.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import UIKit
extension  UIViewController {
    func showAlert(withTitle title: String,
                   withMessage message:String,
                   buttonTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .default)
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
