//
//  LoginRequestAPI.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import Foundation

struct LoginRequestAPI: Encodable {
    let email: String
    let password: String
    
    init(from: LoginRequest) {
        self.email = from.email
        self.password = from.password
    }
    
    func authEncodedInfo() -> String? {
        return "\(email):\(password)".data(using: .utf8)?.base64EncodedString()
    }
}
