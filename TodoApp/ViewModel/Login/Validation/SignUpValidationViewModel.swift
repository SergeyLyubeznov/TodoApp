//
//  SignUpValidationViewModelTest.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 03.03.2023.
//

import Foundation
import Combine

class SignUpValidationViewModel: LoginValidationViewModel {
    // Input values
    @Published var confirmPassword = ""
    
    override var isFormValidPublisher: AnyPublisher<Bool, Never> {
          Publishers.CombineLatest3(
              isUserEmailValidPublisher,
              isPasswordValidPublisher,
              passwordMatchesPublisher)
              .map { isEmailValid, isPasswordValid, passwordMatches in
                  return isEmailValid && isPasswordValid && passwordMatches
              }
              .eraseToAnyPublisher()
    }
}

extension SignUpValidationViewModel {
    
    var passwordMatchesPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confirmPassword)
            .map { password, repeated in
                return password == repeated
            }
            .eraseToAnyPublisher()
    }
}
