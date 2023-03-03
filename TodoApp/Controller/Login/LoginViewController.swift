//
//  LoginViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {

    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    
    var coordintator: ((LoginCoordinator.Destination) -> Void)?
    
    private var viewModel: LoginViewModel?
    private var validationViewModel = LoginValidationViewModel()
    private var cancellableSet: Set<AnyCancellable> = []
    lazy private var activityView = {ActivityIndicatorView.instantiate()}()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSiblings()
        setupValidationSiblings()
        setupActivityIndicator()
    }
    
    func setViewModel(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupActivityIndicator() {
        self.view.addSubview(self.activityView)
        activityView.stopAnimating()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityView.center = self.view.center
    }
    
    // MARK: - Actions
    @IBAction private func loginButtonPressed() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel?.login(email: email, password: password)
    }
    
    @IBAction private func closeButtonPressed() {
        coordintator?(.close)
    }
}

// MARK: - Combine
extension LoginViewController {
    
    private func setupValidationSiblings() {
        
        emailTextField.textPublisher
            .assign(to: \.email, on: validationViewModel)
            .store(in: &cancellableSet)
        
        passwordTextField.textPublisher
            .assign(to: \.password, on: validationViewModel)
            .store(in: &cancellableSet)
        
        validationViewModel.$isValid
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellableSet)
    }
    
    private func setupSiblings() {
        
        viewModel?.$success
            .sink { [weak self] state in
                if state {
                    self?.coordintator?(.initial)
                }
            }
            .store(in: &cancellableSet)
        
        viewModel?.$error
            .sink { [weak self] error in
                if let error = error {
                    self?.showErrorAlert(error: error)
                }
            }
            .store(in: &cancellableSet)
        
        viewModel?.$activityIndicator
            .sink { [weak self] state in
                if state {
                    self?.activityView.startAnimating()
                } else {
                    self?.activityView.stopAnimating()
                }
            }
            .store(in: &cancellableSet)
    }
}

extension LoginViewController: Storyboarded {
    static var storyboardName: String {Constants.Storyboard.Login}
}
