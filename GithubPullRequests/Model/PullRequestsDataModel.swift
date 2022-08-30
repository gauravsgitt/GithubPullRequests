//
//  UserDataModel.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 18/08/22.
//

import Foundation

struct PullRequestsDataModel {
    var title: String
    var dateCreated: String
    var dateClosed: String
    var userDetails: UserDetailsModel
    
    init(title: String, dateCreated: String, dateClosed: String, userDetails: UserDetailsModel) {
        self.title = title
        self.dateCreated = dateCreated
        self.dateClosed = dateClosed
        self.userDetails = userDetails
    }
}
