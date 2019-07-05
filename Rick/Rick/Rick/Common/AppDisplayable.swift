//
//  AppDisplayable.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit

/// Handles common UIViewController action like alerts and prompts
protocol AppDisplayable {
    func display(_ error: Error, handler: ((()) -> Void)?)
}

extension AppDisplayable where Self: UIViewController {
    
    func display(_ error: Error, handler: ((()) -> Void)?) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            handler?(())
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
