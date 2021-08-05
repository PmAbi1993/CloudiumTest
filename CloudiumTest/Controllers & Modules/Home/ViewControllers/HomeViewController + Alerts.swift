//
//  HomeViewController + Alerts.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//

import UIKit

enum HomeDataError: Error {
    case imporoperName
    case improperNumberOfseats
    case general
    var errorTitle: String {
        switch self {
        case .imporoperName:
            return "Please provide valid username"
        case .improperNumberOfseats:
            return "Please provide valid number of seat"
        case .general:
            return "Incorrect Details"

        }
    }
}

extension HomeViewController {
    func getNameAndNumberOfSeats(completion: @escaping (Result< HomeItemsModel, HomeDataError>) -> ()) {
        let alertController = UIAlertController(title: "Booking details",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Number Of seats"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Proceed",
                                        style: .default) {
            (alert) in
            guard let textFields = alertController.textFields else {
                completion(.failure(.general))
                return }
            guard let nameTextField: UITextField = textFields[safe: 0] else {
                completion(.failure(.imporoperName))
                return }

            guard let numberOfSeatsField: UITextField = textFields[safe: 1] else {
                completion(.failure(.improperNumberOfseats))
                return }
            
            alertController.dismiss(animated: true) {
                
                guard let name: String = nameTextField.text,
                      let numberOfseats: Int = Int(numberOfSeatsField.text ?? "") else {
                        completion(.failure((nameTextField.text ?? "").isEmpty ? .imporoperName: .improperNumberOfseats))
                    return }
                
                completion(.success(.bookTickets(name: name,
                                                 tickets: numberOfseats)))
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default, handler: {
                                            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert(error: HomeDataError) {
        
        let alertDisapperTimeInSeconds = 2.0
        let alert = UIAlertController(title: nil,
                                      message: error.errorTitle,
                                      preferredStyle: .actionSheet)
        self.navigationController?.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
            alert.dismiss(animated: true)
        }
    }
}

