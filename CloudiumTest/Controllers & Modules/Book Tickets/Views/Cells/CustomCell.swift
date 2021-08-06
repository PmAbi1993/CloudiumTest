//
//  CustomCell.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var label: UILabel = {
        
        let view: UILabel = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 8
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    func configureWith(_ indexPath: IndexPath, seatStatus: SeatStatus) {
        
        guard let section = SeatType(rawValue: indexPath.section) else {
            fatalError()
        }
        contentView.backgroundColor = seatStatus.color
        isHidden = seatStatus.isHidden
        
        switch seatStatus {
        case .placeholder:
            label.text = section.getSeatName(indexPath)
        default:
            label.text = nil
        }
    }
    
    func configureWith(_ indexPath: IndexPath, viewModel: BookSeatViewModel) {
        
        guard let section = SeatType(rawValue: indexPath.section) else {
            return
        }
      
        if indexPath.row%(section.rowsInSet) == 0 {
            contentView.backgroundColor = .green
            isHidden = false
            label.text = section.getSeatName(indexPath)
        } else if indexPath.row%section.rowToHide == 0 {
            isHidden = true
            label.text = nil
        } else  {
            contentView.backgroundColor = .blue
            isHidden = false
            label.text = nil
            if viewModel.selectedSeats.contains(section.seatID(indexPath)) {
                contentView.backgroundColor = .red
            } else {
                contentView.backgroundColor = .blue
            }
        }
    }
}
