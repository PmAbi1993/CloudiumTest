//
//  BookTicketsFooter.swift
//  CloudiumTest
//
//  Created by admin on 05/08/21.
//

import UIKit

class BookTicketsFooter: UIView {

    var label: PaddingLabel = {
        
        let view: PaddingLabel = PaddingLabel(withInsets: 8, 8, 8, 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .green
        view.textAlignment = .right
        view.text = "Ticket price: RS 0.0 "
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }
}
