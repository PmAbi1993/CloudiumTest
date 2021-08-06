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
        collectionView.backgroundColor = .appBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self,
                                forCellWithReuseIdentifier: String(describing: CustomCell.self))
        collectionView.register(Header.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: Header.self))
        collectionView.register(BookTicketsFooter.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: String(describing: BookTicketsFooter.self))
        return collectionView
    }()

    init(name: String, noOfSeats: Int) {
        super.init(nibName: nil, bundle: nil)
        viewModel = .init(numberOfSeatsToSelect: noOfSeats,
                          userName: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Book Seats"
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        viewModel = .init(numberOfSeatsToSelect: 3)
        extendedLayoutIncludesOpaqueBars = true

        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    @objc func handleBuy() {
        let alert = UIAlertController(title: "Buy Seats",
                                      message: "Buy Seats for \(viewModel.currentTicketPrice)?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Buy",
                                      style: .default,
                                      handler: { [weak self] _ in
                                        self?.viewModel.saveSeatsInSelection {
                                            self?.showBookingInformation()
                                        }
                                      }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        self.navigationController?.present(alert,
                                           animated: true,
                                           completion: nil)
    }
    private func showBookingInformation() {
        showAlert(message: "Seats Booked Successfully",
                  closeIn: 1.0) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateBuyButton() {
        let price: Double = viewModel.currentTicketPrice
        if price > 0 {
            let profileButton = UIButton()
            profileButton.frame = CGRect(x:0, y:30, width:100, height:30)
            profileButton.setTitle("Buy: \(price)", for: .normal)
            profileButton.backgroundColor = .accentColor
            profileButton.setTitleColor(.white, for: .normal)
            profileButton.layer.cornerRadius = 5.0
            profileButton.addTarget(self, action: #selector(handleBuy), for: .touchUpInside)
            
            let rightBarButton = UIBarButtonItem(customView: profileButton)
            self.navigationItem.rightBarButtonItem = rightBarButton
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
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
                updateBuyButton()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width,
              height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .init(width: view.frame.width,
              height: section == 2 ? 45 : 0)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header: Header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: String(describing: Header.self),
                    for: indexPath) as? Header else {
                fatalError()
            }
            header.configureHeader(seat: SeatType(rawValue: indexPath.section))
            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer: BookTicketsFooter = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: String(describing: BookTicketsFooter.self),
                    for: indexPath) as? BookTicketsFooter else {
                fatalError()
            }
            footer.configureWith(price: viewModel.currentTicketPrice)
            return footer
        default:
            fatalError()
        }
    }
}

// MARK: Footer
extension BookTicketViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let seatType: SeatType = SeatType(rawValue: indexPath.section) else { fatalError() }
        let noOfCellsInRow = seatType.rowsInSet
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
}


