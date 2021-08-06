//
//  Coordinator.swift
//  Flags
//
//  Created by admin on 18/07/21.
//

import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
