//
//  Extensions.swift
//  GithubPullRequests
//
//  Created by Gaurav Bisht on 19/08/22.
//

import Foundation
import UIKit

//extension UIViewController {
//  func showAlert(title: String, message: String) {
//    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in }))
//    self.present(alert, animated: true, completion: nil)
//  }
//}

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

extension UIActivityIndicatorView {
    func dismissLoader() {
        DispatchQueue.main.sync {
            self.stopAnimating()
        }
    }
}
