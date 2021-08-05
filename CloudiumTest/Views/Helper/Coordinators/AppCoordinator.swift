//
//  AppCoordinator.swift
//  Flags
//
//  Created by admin on 18/07/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
//        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        self.navigationController.navigationBar.isTranslucent = false
        
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.barTintColor = .white //= [.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.tintColor = .white
        
    }
    func start() {
        let controller: HomeViewController = .instance()
        controller.coordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateTo(item: HomeItemsModel) {
        switch item {
        case .bookTickets(name: let name, tickets: let noOfTickets):
            let bookTicketsController: BookTicketViewController = .init(name: name,
                                                                        noOfSeats: noOfTickets)
            self.navigationController.pushViewController(bookTicketsController,
                                                         animated: true)
        case .showBookedTickets:
            let showBookedTickets: BookedTicketsVC = BookedTicketsVC()
            self.navigationController.pushViewController(showBookedTickets,
                                                         animated: true)
        case .clearAllData: break
        }
    }
}
