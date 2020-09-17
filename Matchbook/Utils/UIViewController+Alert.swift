//
//  UIViewController+Alert.swift
//  Matchbook
//
//  Created by Nayely on 08/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach({ alert.addAction($0) })
        if actions?.isEmpty ?? true {
            alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: nil))
        }
        present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(error: Error, actions: [UIAlertAction]?) {
        self.presentAlert(title: "Error", message: error.localizedDescription, actions: nil)
    }
}

