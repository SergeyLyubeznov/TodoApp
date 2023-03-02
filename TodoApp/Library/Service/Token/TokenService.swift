//
//  TokenService.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import Foundation

protocol TokenService {
    func save(accessToken: String)
    func read() -> String?
    func delete()
}

final class TokenKeychanService: TokenService {
    
    private let service = "access-token"
    private let account = "todoapp"
    private let keychan = KeychainHelper.shared
    
    func save(accessToken: String) {
        let data = Data(accessToken.utf8)
        keychan.save(data, service: service, account: account)
    }
    
    func read() -> String? {
        if let data = keychan.read(service: service, account: account),
           let accessToken = String(data: data, encoding: .utf8) {
            return accessToken
        }
        return nil
    }
    
    func delete() {
        keychan.delete(service: service, account: account)
    }
}
