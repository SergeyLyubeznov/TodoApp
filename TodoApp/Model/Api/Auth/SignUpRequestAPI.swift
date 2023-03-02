//
//  SignUpRequestAPI.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import Foundation

struct SignUpRequestAPI: Encodable {
    let email: String
    let password: String
    let confirmPassword: String
    
    init(from: SignUpRequest) {
        self.email = from.email
        self.password = from.password
        self.confirmPassword = from.confirmPassword
    }
}
