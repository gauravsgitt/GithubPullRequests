//
//  UserDetailsModel.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 30/08/22.
//

import Foundation

struct UserDetailsModel {
    var avatarURL: String
    var login: String
    
    init(dict: [String: Any]) {
        self.avatarURL = dict["avatar_url"] as? String ?? ""
        self.login = dict["login"] as? String ?? ""
    }
}
