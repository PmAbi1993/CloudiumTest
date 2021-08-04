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
    }
    func start() {
        let controller: HomeViewController = .instance()
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.pushViewController(controller, animated: true)
    }
}
