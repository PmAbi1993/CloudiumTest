//
//  Header.swift
//  CompositionalLayout
//
//  Created by admin on 31/07/21.
//

import UIKit

class Header: UICollectionReusableView {
    
    var label: UILabel = {
        
        let view: UILabel = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red

        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true


    }
    
    func configureHeader(seat: SeatType?) {
        guard let seat = seat else { return }
        label.text = seat.seatTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
