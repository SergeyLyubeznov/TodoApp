//
//  UserAPI.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import Foundation

struct UserAPI: Decodable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
}

extension UserAPI {
    func convertToUser() -> User {
        return User(id: id, email: email, firstName: firstName, lastName: lastName)
    }
}
