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
            let alert = UIAlertController(title: "Clear DB",
                                          message: "This will clear all the saved tickets",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Proceed",
                                          style: .default,
                                          handler: { [weak self] _ in
                                            print("Deleting all dbItems")
                                            self?.viewModel.clearAllItemsInDb {
                                                
                                            }
                                          }))
            alert.addAction(UIAlertAction(title: "Cancel",
                                          style: .cancel,
                                          handler: nil))
            self.navigationController?.present(alert,
                                               animated: true,
                                               completion: nil)
        case .bookTickets:
            getNameAndNumberOfSeats { [weak self] (result) in
                switch result {
                case .success(let item):
                    self?.coordinator?.navigateTo(item: item)
                case .failure(let error):
                    self?.showErrorAlert(error: error)
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

