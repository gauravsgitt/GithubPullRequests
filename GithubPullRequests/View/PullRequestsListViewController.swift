//
//  MainViewController.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 16/08/22.
//

import UIKit

class PullRequestsListViewController: UIViewController, HelpingFunctions {

    //MARK: IBOutlets
    @IBOutlet weak var userDetailsTableView: UITableView!
    @IBOutlet weak var usernameAndRepoLabel: UILabel!
    
    var pullRequestsList = [PullRequestsDataModel]()
    var viewModel: PullRequestsListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell(tableView: self.userDetailsTableView, nibName: "DetailsTableViewCell", identifier: "DetailsTableViewCell")
        self.registerTableViewCell(tableView: self.userDetailsTableView, nibName: "UsernameUserImageHeaderTableViewCell", identifier: "UsernameUserImageHeaderTableViewCell")
        self.setupUsernameAndRepoLabel()
    }

    //MARK: Function to call  API to get all pull requests wrt state of the pull requests
    func populateClosedPullRequestsArray() {
        
        FetchPullRequestsDataController.shared.delegate = self
        FetchPullRequestsDataController.shared.getData(repo: self.viewModel?.repo ?? "", username: self.viewModel?.username ?? "", owner: self.viewModel?.owner ?? "", state: .closed, view: self.view)
    }
    
    //MARK: Funtion to set username and repository labels
    private func setupUsernameAndRepoLabel() {
        self.usernameAndRepoLabel.text = "\(self.viewModel?.username ?? "") / \(self.viewModel?.repo ?? "")"
    }
}

//MARK: UITableViewDelegate and UITableViewDataSource
extension PullRequestsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.pullRequestsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if self.pullRequestsList.count != 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as? DetailsTableViewCell else { return UITableViewCell() }
            cell.configCell(username: self.pullRequestsList[indexPath.row].userDetails.login,
                            title: self.pullRequestsList[indexPath.row].title,
                            dateCreated: self.pullRequestsList[indexPath.row].dateCreated,
                            dateClosed: self.pullRequestsList[indexPath.row].dateClosed,
                            imageURL: self.pullRequestsList[indexPath.row].userDetails.avatarURL)
            return cell
        } else {
            //debugPrint(dataNotFound)
            return UITableViewCell()
        }
    }
}

//MARK: Fetch Pull Requests Protocol
extension PullRequestsListViewController: FetchPullRequestsProtocol {
    
    //To show alert
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        DispatchQueue.main.sync {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Called when API call is done successfully
    func pullRequestsDataFetched(dataArray: [PullRequestsDataModel]) {
        self.pullRequestsList = dataArray
        DispatchQueue.main.sync {
            self.userDetailsTableView.reloadData()
        }
    }
}
