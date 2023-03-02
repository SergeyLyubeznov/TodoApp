//
//  AuthResponseAPI.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import Foundation

struct AuthResponseAPI: Decodable {
    let token: String
    let user: UserAPI
}

extension AuthResponseAPI {
    func convertToAuthResponse() -> AuthResponse {
        return AuthResponse(token: token, user: user.convertToUser())
    }
}
