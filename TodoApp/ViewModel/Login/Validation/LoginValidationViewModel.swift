//
//  LoginValidationViewModel.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 03.03.2023.
//

import Foundation
import Combine

class LoginValidationViewModel {
    
    // Input values
    @Published var email = ""
    @Published var password = ""
    
    // Output subscribers
    @Published var isValid = false
    
    private var publishers = Set<AnyCancellable>()
    
    var isFormValidPublisher: AnyPublisher<Bool, Never> {
          Publishers.CombineLatest(
              isUserEmailValidPublisher,
              isPasswordValidPublisher)
              .map { isEmailValid, isPasswordValid in
                  return isEmailValid && isPasswordValid
              }
              .eraseToAnyPublisher()
    }
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &publishers)
    }
}

extension LoginValidationViewModel {
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Constants.Valid.EmailRegEx)
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { password in
                return password.count >= Constants.Valid.PasswordLenght
            }
            .eraseToAnyPublisher()
    }
}
