//
//  Enums.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 28/08/22.
//

import Foundation

enum StateType {
    case open
    case closed
    case all
    
    var description: String {
        switch self {
        case .open:
            return "open"
        case .closed:
            return "closed"
        case .all:
            return "all"
        }
    }
}

enum ValidationResult {
    case failed(message: String)
    case success
    
    var isValid: Bool {
        switch self {
        case .failed:
            return false
        case .success:
            return true
        }
    }
}
