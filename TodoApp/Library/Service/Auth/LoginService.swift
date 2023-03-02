//
//  AuthService.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import Foundation

typealias LoginResult = (Result<AuthResponse, Error>) -> Void

protocol LoginService {
    func signUp(request: SignUpRequest, _ completion: @escaping(LoginResult))
    func login(request: LoginRequest, _ completion: @escaping(LoginResult))
}

class LoginNetworkService: NetworkService, LoginService {
   
    override var accessTokenType: NetworkService.AccessTokenType {.basic}
    
    func login(request: LoginRequest, _ completion: @escaping (LoginResult)) {
        if let token = LoginRequestAPI(from: request).authEncodedInfo() {
            setAccesToken(token)
        }
        post(route: .login) { (response: Result<AuthResponseAPI, Error>) in
            do {
                let response = try response.get().convertToAuthResponse()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func signUp(request: SignUpRequest, _ completion: @escaping (LoginResult)) {
        let data = try? JSONEncoder().encode(SignUpRequestAPI(from: request))
        post(route: .signUp, body: data) { (response: Result<AuthResponseAPI, Error>) in
            do {
                let response = try response.get().convertToAuthResponse()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
