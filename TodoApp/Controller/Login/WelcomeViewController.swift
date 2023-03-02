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
//        let controller = LoginViewController.instantiate()
//        let viewModel = LoginViewModel(networkService: LoginNetworkService())
//        controller.setViewModel(viewModel)
//        self.present(controller, animated: true)
        coordintator?(.login)
    }
    
    @IBAction private func signUpButtonPressed() {
//        let controller = SignUpViewController.instantiate()
//        let viewModel = SignUpViewModel(networkService: LoginNetworkService())
//        controller.setViewModel(viewModel)
//        self.present(controller, animated: true)
        coordintator?(.signUp)
    }
}

// MARK: - Storyboarded
extension WelcomeViewController: Storyboarded {
    static var storyboardName: String {Constants.Storyboard.Login}
}
