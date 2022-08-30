//
//  PullRequestsDataViewModel.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 28/08/22.
//

import Foundation

class PullRequestsDataViewModel {
    
    var pullRequestsDataModel: PullRequestsDataModel
    
    init(pullRequestsDataModel: PullRequestsDataModel) {
        self.pullRequestsDataModel = pullRequestsDataModel
    }
    
    var title: String {
        return self.pullRequestsDataModel.title
    }
    
    var dateCreated: String {
        return self.pullRequestsDataModel.dateCreated
    }
    
    var dateClosed: String {
        return self.pullRequestsDataModel.dateClosed
    }

}
