//
//  UIViewController + Alert.swift
//  CloudiumTest
//
//  Created by admin on 06/08/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String, closeIn: Double = 2, completion: @escaping () -> ()) {
        
        let alertDisapperTimeInSeconds = closeIn
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .actionSheet)
        self.navigationController?.present(alert,
                                           animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
            alert.dismiss(animated: true) {
                completion()
            }
        }
    }
    
}
