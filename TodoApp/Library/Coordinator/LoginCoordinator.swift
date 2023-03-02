//
//  LoginCoordinator.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import UIKit

class LoginCoordinator {
    
    var coordinatorClose: (() -> Void)?
    
    private var navigationController: UINavigationController
    
    init(controller: UINavigationController) {
        self.navigationController = controller
        let controller = WelcomeViewController.instantiate()
        controller.coordintator = {self.show($0)}
        navigationController.pushViewController(controller, animated: true)
    }
    
    #if DEBUG
    deinit {
        print("Deinit - \(String(describing: self))")
    }
    #endif
}

extension LoginCoordinator: Coordinator {
    enum Destination {
        case initial
        case close
        case login
        case signUp
    }
    
    func show(_ destination: Destination) {
        switch destination {
        case .close:
            navigationController.presentedViewController?.dismiss()
        case .login:
            showLoginController()
        case .signUp:
            showSignUpController()
        case .initial:
            navigationController.presentedViewController?.dismiss(animated: true, completion: {
                self.coordinatorClose?()
            })
        }
    }
    
    func showLoginController() {
        let controller = LoginViewController.instantiate()
        let viewModel = LoginViewModel(networkService: LoginNetworkService())
        controller.setViewModel(viewModel)
        controller.coordintator = {self.show($0)}
        self.navigationController.present(controller, animated: true)
        
    }

    func showSignUpController() {
        let controller = SignUpViewController.instantiate()
        let viewModel = LoginViewModel(networkService: LoginNetworkService())
        controller.setViewModel(viewModel)
        controller.coordintator = {self.show($0)}
        self.navigationController.present(controller, animated: true)
    }
}
