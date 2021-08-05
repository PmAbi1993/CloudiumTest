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
    case seatsNotAvailable
    case general
    case dbCleared
    var errorTitle: String {
        switch self {
        case .imporoperName:
            return "Please provide valid username"
        case .improperNumberOfseats:
            return "Please provide valid number of seat"
        case .general:
            return "Incorrect Details"
        case .seatsNotAvailable:
            let viewModel: HomeVCViewModel = .init()
            return "Sorry, Only \(viewModel.availableSeats()) seats available "
        case .dbCleared:
            return "Database has been cleared"
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
            
            alertController.dismiss(animated: true) { [weak self] in
                guard let name: String = nameTextField.text,
                      let numberOfseats: Int = Int(numberOfSeatsField.text ?? "") else {
                        completion(.failure((nameTextField.text ?? "").isEmpty ? .imporoperName: .improperNumberOfseats))
                    return }
                
                if numberOfseats <= 0 {
                    completion(.failure(.improperNumberOfseats))
                } else if numberOfseats >= self?.viewModel.availableSeats() ?? 0 {
                    completion(.failure(.seatsNotAvailable))
                } else {
                    completion(.success(.bookTickets(name: name,
                                                     tickets: numberOfseats - 1)))
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default, handler: {
                                            (action : UIAlertAction!) -> Void in })
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(error: HomeDataError, closeIn: Double = 2) {
        
        let alertDisapperTimeInSeconds = closeIn
        let alert = UIAlertController(title: nil,
                                      message: error.errorTitle,
                                      preferredStyle: .actionSheet)
        self.navigationController?.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func clearDatabase() {
        let alert = UIAlertController(title: "Clear DB",
                                      message: "This will clear all the saved tickets",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Proceed",
                                      style: .default,
                                      handler: { [weak self] _ in
                                        print("Deleting all dbItems")
                                        self?.viewModel.clearAllItemsInDb { [weak self] in
                                            self?.showAlert(error: .dbCleared, closeIn: 1)
                                        }
                                      }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        self.navigationController?.present(alert,
                                           animated: true,
                                           completion: nil)
    }
    
}

