//
//  TableView.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cells: [T.Type]) {
        cells.forEach {
            register($0.self,
                     forCellReuseIdentifier: String(describing: $0.self))
        }
    }
    func dequedCell<T: UITableViewCell>(type: T.Type) -> T {
        guard let cell: T = dequeueReusableCell(
                withIdentifier: String(describing: type.self)) as? T else { fatalError() }
        return cell
    }
}
