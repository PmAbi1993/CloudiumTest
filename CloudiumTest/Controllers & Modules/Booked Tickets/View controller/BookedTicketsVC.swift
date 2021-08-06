//
//  BookedTicketsVC.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import UIKit

class BookedTicketsVC: UIViewController {
    let viewModel: BookedTicketsViewModel = .init()
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        handleTable()
    }
    fileprivate func configureView() {
        self.title = "Booked Tickets"
        view.backgroundColor = .appBackgroundColor
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    fileprivate func handleTable() {
        if viewModel.allSavedSeats.count == 0 {
            tableView.setEmptyMessage("No Tickets purchased yet!!")
        } else {
            tableView.restore()
        }
    }
}

extension BookedTicketsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.allSavedSeats.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSeatsAt(index: section).count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: PaddingLabel = .init(withInsets: 8, 8, 8, 8)
        label.textColor = .white
        let name: String = viewModel.allSavedSeats[section].sessionName ?? ""
        let price: Double = viewModel.allSavedSeats[section].sessionTicketPrice
        label.text = "Name: \(name),  Price: \(price) Rs "
        label.frame = .init(origin: .zero,
                            size: CGSize(width: tableView.frame.width,
                                         height: 40))
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequedCell(type: UITableViewCell.self)
        cell.backgroundColor = .white
        let seat = viewModel.getSeatsAt(index: indexPath.section)[indexPath.row]
        cell.textLabel?.text = seat.seatId
        cell.textLabel?.textColor = .black
        return cell
    }
}
