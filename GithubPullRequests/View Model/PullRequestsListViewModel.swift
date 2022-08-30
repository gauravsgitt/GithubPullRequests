//
//  PullRequestsListViewModel.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 19/08/22.
//

import Foundation

class PullRequestsListViewModel {
    
    var username: String
    var repo: String
    var owner: String
    
    init(username: String, repo: String, owner: String) {
        self.username = username
        self.repo = repo
        self.owner = owner
    }
}
