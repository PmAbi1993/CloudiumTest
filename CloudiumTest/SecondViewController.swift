//
//  SecondViewController.swift
//  CompositionalLayout
//
//  Created by admin on 31/07/21.
//

import UIKit

class SecondViewController: UIViewController, StoryBoardInitiable {
    static var storyBoardName: EXStorBoardName { .default }
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = .init()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.sectionInset = .init(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self,
                                forCellWithReuseIdentifier: String(describing: CustomCell.self))
        collectionView.register(Header.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: Header.self))
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Book Seats"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        

        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

    }


}
extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SeatType.allCases.count// Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SeatType(rawValue: section) else { fatalError() }
        return section.seatsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CustomCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CustomCell.self),
                for: indexPath) as? CustomCell else { fatalError() }
        cell.label.text = String(indexPath.item)

        if let section = SeatType(rawValue: indexPath.section),
           indexPath.row%(section.rowsInSet) == 0 {
            cell.contentView.backgroundColor = .green
        } else  {
            cell.contentView.backgroundColor = .systemBlue
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked on cell seat \(indexPath.row) at section: \(SeatType(rawValue: indexPath.section)!)")
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header: Header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: String(describing: Header.self),
                for: indexPath) as? Header else {
            fatalError()
        }
        header.configureHeader(seat: SeatType(rawValue: indexPath.section))
        return header
    }
    
}


extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width,
              height: 30)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let seatType: SeatType = SeatType(rawValue: indexPath.section) else { fatalError() }
        
        
        switch seatType {
                case .recliner :
                    let noOfRowsInRecliner: CGFloat = CGFloat(seatType.rowsInSet)
                    let itemWidth = (collectionView.frame.width / noOfRowsInRecliner) - (noOfRowsInRecliner) + 4
                    return .init(width: itemWidth,
                                 height: itemWidth)
                case .prime:
                    let noOfRowsInRecliner: CGFloat = CGFloat(seatType.rowsInSet)
        
                    let itemWidth = (collectionView.frame.width / noOfRowsInRecliner) - (noOfRowsInRecliner) + 4
        
                    return .init(width: itemWidth,
                                 height: itemWidth)
                case .classicPlus:
                    let noOfRowsInRecliner: CGFloat = CGFloat(seatType.rowsInSet)
        
                    let itemWidth = (collectionView.frame.width / noOfRowsInRecliner) - (noOfRowsInRecliner) + 4
        
                    return .init(width: itemWidth,
                                 height: itemWidth)
                }

        
        
        
    
        let noOfRowsInRecliner: CGFloat = CGFloat(seatType.rowsInSet)
        let itemWidth = (collectionView.frame.width / noOfRowsInRecliner) - (noOfRowsInRecliner) + 4
        return .init(width: itemWidth,
                     height: itemWidth)
        
    }
}



//        switch seatType {
//        case .recliner :
//            let noOfRowsInRecliner: CGFloat = CGFloat(seatType.rowsInSet)
//            let itemWidth = (collectionView.frame.width / noOfRowsInRecliner) - (noOfRowsInRecliner) + 4
//            return .init(width: itemWidth,
//                         height: itemWidth)
//        case .prime:
//            let noOfRowsInRecliner: CGFloat = CGFloat(seatType.rowsInSet)
//
//            let itemWidth = (collectionView.frame.width / noOfRowsInRecliner) - (noOfRowsInRecliner) + 4
//
//            return .init(width: itemWidth,
//                         height: itemWidth)
//        case .classicPlus:
//            let noOfRowsInRecliner: CGFloat = CGFloat(seatType.rowsInSet)
//
//            let itemWidth = (collectionView.frame.width / noOfRowsInRecliner) - (noOfRowsInRecliner) + 4
//
//            return .init(width: itemWidth,
//                         height: itemWidth)
//        }
class CustomCell: UICollectionViewCell {
    
    
    var label: UILabel = {
        
        let view: UILabel = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
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
    
}