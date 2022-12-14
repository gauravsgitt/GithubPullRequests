//
//  Functions.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 18/08/22.
//

import Foundation
import UIKit

protocol HelpingFunctions {}

extension HelpingFunctions {
    
    //MARK: Register table view cells
    func registerTableViewCell(tableView: UITableView, nibName: String, identifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    //MARK: Apply rounded corners to a view
    func applyRoundedCornersToUIViews(_ view: UIView, radius: Int) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(radius)
    }

    //MARK: Give image views a round shape
    func makeImageViewRounded(_ image: UIImageView) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    
    //MARK: Generate get pull requests API
    func getPullRequestsOfRepoCompleteURL(repo: String, username: String) -> String {
        return getPullRequestsOfRepoBaseURL + "/\(username)/\(repo)/pulls"
        // https://api.github.com/repos/ValveSoftware/Proton/pulls
    }
    
    //MARK: Covert date in "yyyy-MM-dd'T'HH:mm:ssZ" format to "dd-MM-yyyy"
    func convertDateToddMMyyyyFormat(dateInString: String) -> String {
        let string = dateInString
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string) ?? Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = tempLocale
        return dateFormatter.string(from: date)
    }
    
    //MARK: Show loader
    func showLoader(view: UIView) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        spinner.backgroundColor = UIColor.clear
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.medium;
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        
        return spinner
    }
}
