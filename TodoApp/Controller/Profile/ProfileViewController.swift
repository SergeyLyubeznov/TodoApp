//
//  ProfileViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 05.03.2023.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    var coordintator: ((MainCoordinator.Destination) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonPressed() {
        coordintator?(.logout)
    }
}

extension ProfileViewController: Storyboarded {
    static var storyboardName: String {"Profile"}
}
