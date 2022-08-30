//
//  DetailsTableViewCell.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 19/08/22.
//

import UIKit

class DetailsTableViewCell: UITableViewCell, HelpingFunctions {

    //MARK: IBOutlets
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: PaddingLabel!
    @IBOutlet weak var titleLabel: PaddingLabel!
    @IBOutlet weak var dateCreatedLabel: PaddingLabel!
    @IBOutlet weak var dateClosedLabel: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyRoundedCornersToUIViews(self.containerStackView, radius: 20)
        self.configProfilePictureImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Function to configure profile picture image view
    private func configProfilePictureImageView() {
        self.applyRoundedCornersToUIViews(self.profilePictureImageView, radius: 10)
//        self.profilePictureImageView.layer.borderWidth = 1
//        self.profilePictureImageView.layer.borderColor = UIColor.black.cgColor
        self.profilePictureImageView.layer.masksToBounds = true
    }
    
    //MARK: Configure pull requests tableView cell
    func configCell(username: String, title: String, dateCreated: String, dateClosed: String, imageURL: String) {
        self.userNameLabel.text = username
        self.titleLabel.text = title
        self.dateCreatedLabel.text = dateCreated
        self.dateClosedLabel.text = dateClosed
        self.profilePictureImageView.loadFrom(URLAddress: imageURL)
    }
    
}
