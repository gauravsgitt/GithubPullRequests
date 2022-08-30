//
//  Extensions.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 19/08/22.
//

import Foundation
import UIKit

//MARK: UIImageView
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

//MARK: UIActivityIndicatorView
extension UIActivityIndicatorView {
    func dismissLoader() {
        DispatchQueue.main.sync {
            self.stopAnimating()
        }
    }
}
