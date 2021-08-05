//
//  HomeViewController.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSource: [HomeItemsModel] = HomeItemsModel.allItems
    var viewModel: HomeVCViewModel = .init()
    
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
    }
    fileprivate func configureView() {
        self.title = "Home"
        view.backgroundColor = .appBackgroundColor
    }
    fileprivate func configureTableView() {
        tableView.backgroundColor = .appBackgroundColor
        tableView.register([HomeItemsTableCell.self])
        tableView.separatorStyle = .none
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeItemsTableCell = tableView.dequedCell(type: HomeItemsTableCell.self)
        cell.configureWith(dataSource[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        
        switch dataSource[indexPath.row] {
        case .clearAllData:
            clearDatabase()
        case .bookTickets:
            getNameAndNumberOfSeats { [weak self] (result) in
                switch result {
                case .success(let item):
                    self?.coordinator?.navigateTo(item: item)
                case .failure(let error):
                    self?.showAlert(error: error)
                }
            }
        default:
            coordinator?.navigateTo(item: dataSource[indexPath.row])
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
extension HomeViewController: StoryBoardInitiable {
    static var storyBoardName: EXStorBoardName { .default }
}

