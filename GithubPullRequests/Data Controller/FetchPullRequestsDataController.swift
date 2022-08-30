//
//  FetchPullRequestsDataController.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 19/08/22.
//

import Foundation
import UIKit

protocol FetchPullRequestsProtocol {
    func showAlert(title: String, message: String)
    func pullRequestsDataFetched(dataArray: [PullRequestsDataModel])
}

class FetchPullRequestsDataController: HelpingFunctions {
    
    static let shared = FetchPullRequestsDataController()
    
    var delegate: ShowErrorProtocol?
    
    //MARK: Function to get all pull requests wrt its state
    func getData(repo: String, username: String, owner: String, state: StateType, view: UIView) {
        //Initialize loader
        let spinner = self.showLoader(view: view)
        
        //Resultant array containing all required pull requests
        var dataArr = [PullRequestsDataModel]()
        
        //URL with query items
        let url = URL(string: self.getPullRequestsOfRepoCompleteURL(repo: repo, username: username))
        var components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "owner", value: username),
                                  URLQueryItem(name: "repo", value: repo),
                                  URLQueryItem(name: "state", value: state.description)]

        //Headers
        let headers = ["content-type": "application/json",
                       "accept": "application/vnd.github+json"]

        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //Dismiss loader when you get API hit successfully
            spinner.dismissLoader()
            //debugPrint("url=======", (components?.url)!)
            //debugPrint("headers=======", headers as Any)

            if error != nil {
                
                //debugPrint("error=======", error?.localizedDescription ?? somethingWentWrong)
                self.delegate?.showAlert(title: errorText,message: error?.localizedDescription ?? somethingWentWrong)
                
            } else if data != nil && data?.count != 0 {
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    if let jsonDictArray = jsonData as? [Any] {
                        for item in jsonDictArray as! [Dictionary<String, AnyObject>] {
                            dataArr.append(PullRequestsDataModel(title: item["title"] as? String ?? "",
                                                                 dateCreated: self.convertDateToddMMyyyyFormat(dateInString: item["created_date"] as? String ?? ""),
                                                                 dateClosed: self.convertDateToddMMyyyyFormat(dateInString: item["closed_date"] as? String ?? ""),
                                                                 userDetails: UserDetailsModel(dict: item["user"] as? [String : Any] ?? ["": ""])))
                            dataArr = dataArr.filter { $0.userDetails.login == owner}
                        }
                        
                        if dataArr.count != 0 {
                            self.delegate?.pullRequestsDataFetched(dataArray: dataArr)
                        } else {
                            self.delegate?.showAlert(title: "", message: noClosedPullRequests)
                        }
                        
                    } else {
                        self.delegate?.showAlert(title: errorText, message: dataNotFound)
                    }
                } catch let jsonError {
                    
                    //debugPrint(jsonError.localizedDescription)
                    self.delegate?.showAlert(title: errorText, message: jsonError.localizedDescription)
                }
            }
        }.resume()
    }
}
