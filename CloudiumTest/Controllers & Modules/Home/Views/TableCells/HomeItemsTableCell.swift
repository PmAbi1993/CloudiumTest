//
//  HomeItemsTableCell.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//

import UIKit

class HomeItemsTableCell: UITableViewCell {

    private var label: PaddingLabel = {
        let containerView: PaddingLabel = PaddingLabel(withInsets: 8, 8, 8, 8)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .accentColor
        containerView.font = .boldSystemFont(ofSize: 16)
        containerView.textColor = .white
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
        return containerView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    fileprivate func commonInit() {
        contentView.backgroundColor = .appBackgroundColor
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    func configureWith(_ item: HomeItemsModel) {
        label.text = item.title
    }
}
