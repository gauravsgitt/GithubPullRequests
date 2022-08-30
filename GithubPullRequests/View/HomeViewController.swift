//
//  HomeViewController.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 19/08/22.
//

import UIKit

class HomeViewController: UIViewController, HelpingFunctions {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var repoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fetchDetailsBtnOutlet: UIButton!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameTextField.delegate = self
        self.repoTextField.delegate = self
        self.applyRoundedCornersToUIViews(self.fetchDetailsBtnOutlet, radius: 15)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userNameTextField.text = ""
        self.repoTextField.text = ""
        self.nameTextField.text = ""
        self.userNameTextField.becomeFirstResponder()
    }
    
    @IBAction func fetchDetails(_ sender: UIButton) {
        let status = self.viewModel.checkValidation(username: self.userNameTextField.text ?? "",
                                                    repo: self.repoTextField.text ?? "",
                                                    name: self.nameTextField.text ?? "")
        
        if status.isValid {
            let storyBoard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PullRequestsListViewController") as! PullRequestsListViewController
            vc.viewModel = PullRequestsListViewModel(username: self.userNameTextField.text ?? "", repo: self.repoTextField.text ?? "", owner: self.nameTextField.text ?? "")
            vc.populateClosedPullRequestsArray()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showAlert(message: status.message)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.userNameTextField {
            textField.resignFirstResponder()
            self.repoTextField.becomeFirstResponder()
            return true
        } else if textField == self.repoTextField {
            textField.resignFirstResponder()
            self.nameTextField.becomeFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        self.fetchDetailsBtnOutlet.sendActions(for: .touchUpInside)
        return true
    }
}
