//
//  HomeViewModel.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 29/08/22.
//

import Foundation

class HomeViewModel {
    
    //MARK: Function to check if all fields are filled
    func checkValidation(username: String, repo: String, name: String) -> (isValid: Bool, message: String) {
        if username.isEmpty {
            return (isValid: false, message: enterUsername)
        }
        if repo.isEmpty {
            return (isValid: false, message: enterRepo)
        }
        if name.isEmpty {
            return (isValid: false, message: enterName)
        }
        return (isValid: true, message: "")
    }
}
