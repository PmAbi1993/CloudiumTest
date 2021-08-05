//
//  SecondViewController.swift
//  CompositionalLayout
//
//  Created by admin on 31/07/21.
//

import UIKit

class BookTicketViewController: UIViewController, StoryBoardInitiable {
    static var storyBoardName: EXStorBoardName { .default }
    
    var viewModel: BookSeatViewModel!
    
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = .init()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.sectionInset = .init(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .appBackgroundColor// UIColor("#18191E")//#18191E
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
        viewModel = .init(numberOfSeatsToSelect: 3)

        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

    }


}
extension BookTicketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SeatType.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SeatType(rawValue: section) else { fatalError() }
        return section.seatsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CustomCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CustomCell.self),
                for: indexPath) as? CustomCell else { fatalError() }
        cell.configureWith(indexPath,
                           seatStatus: viewModel.getSeatStatus(at: indexPath))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.handleSeatSelection(indexPath: indexPath) { [weak self] status in
            if status {
                self?.collectionView.reloadData()
            }
        }
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


extension BookTicketViewController: UICollectionViewDelegateFlowLayout {
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


