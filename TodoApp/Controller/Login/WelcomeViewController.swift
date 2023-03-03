//
//  WelcomeViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    var coordintator: ((LoginCoordinator.Destination) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction private func loginButtonPressed() {
        coordintator?(.login)
    }
    
    @IBAction private func signUpButtonPressed() {
        coordintator?(.signUp)
    }
}

// MARK: - Storyboarded
extension WelcomeViewController: Storyboarded {
    static var storyboardName: String {Constants.Storyboard.Login}
}
