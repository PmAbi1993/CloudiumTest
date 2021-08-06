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
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                 width: self.bounds.size.width,
                                                 height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .boldSystemFont(ofSize: 17)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
