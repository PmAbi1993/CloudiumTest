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
    //MARK: Nav Configurations
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.shadowImage = UIImage()
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
