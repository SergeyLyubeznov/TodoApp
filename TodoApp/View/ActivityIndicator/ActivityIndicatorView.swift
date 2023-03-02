//
//  ActivityIndicatorView.swift
//  TestShopFirebase
//
//  Created by Serhii Liubeznov on 10.02.2023.
//

import UIKit

class ActivityIndicatorView: UIView, Xibed {
    
    @IBOutlet private weak var activityView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
    }
    
    func startAnimating() {
        self.isHidden = false
        activityView.startAnimating()
    }
    
    func stopAnimating() {
        self.isHidden = true
        activityView.stopAnimating()
    }
}
