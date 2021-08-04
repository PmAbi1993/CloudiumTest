//
//  HomeViewController.swift
//  CloudiumTest
//
//  Created by admin on 04/08/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        view.backgroundColor = .systemBlue
        tableView.backgroundColor = .systemBlue
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = "cell \(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller: SecondViewController = .init()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension HomeViewController: StoryBoardInitiable {
    static var storyBoardName: EXStorBoardName { .default }
}
