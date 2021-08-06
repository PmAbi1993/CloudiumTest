//
//  Header.swift
//  CompositionalLayout
//
//  Created by admin on 31/07/21.
//

import UIKit

class BookTicketsHeader: UICollectionReusableView {
    
    var label: PaddingLabel = {
        
        let view: PaddingLabel = PaddingLabel(withInsets: 8, 8, 8, 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 17)
//        view.layer.borderWidth = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

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
