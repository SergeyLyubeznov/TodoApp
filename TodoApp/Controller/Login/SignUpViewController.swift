//
//  SignUpViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import UIKit
import Combine

class SignUpViewController: BaseViewController {

    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!
    @IBOutlet private var signUpButton: UIButton!
    
    var coordintator: ((LoginCoordinator.Destination) -> Void)?
    
    private var viewModel: LoginViewModel?
    private var validationViewModel = SignUpValidationViewModel()
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
    @IBAction private func signUpButtonPressed() {
        let email = validationViewModel.email//emailTextField.text ?? ""
        let password = validationViewModel.password//passwordTextField.text ?? ""
        let confirmPassword = validationViewModel.confirmPassword//.text ?? ""
        viewModel?.signUp(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    @IBAction private func closeButtonPressed() {
        coordintator?(.close)
    }
}

// MARK: - Combine
extension SignUpViewController {
    
    private func setupValidationSiblings() {
        
        emailTextField.textPublisher
            .assign(to: \.email, on: validationViewModel)
            .store(in: &cancellableSet)
        
        passwordTextField.textPublisher
            .assign(to: \.password, on: validationViewModel)
            .store(in: &cancellableSet)
        
        confirmPasswordTextField.textPublisher
            .assign(to: \.confirmPassword, on: validationViewModel)
            .store(in: &cancellableSet)
        
        validationViewModel.$isValid
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signUpButton)
            .store(in: &cancellableSet)
    }
    
    private func setupSiblings() {
        
        viewModel?.$success
            .sink { [weak self] success in
                if success {
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

extension SignUpViewController: Storyboarded {
    static var storyboardName: String {Constants.Storyboard.Login}
}
