//
//  LoginViewModel.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import Foundation

class LoginViewModel: ViewModel {
    
    @Published var success = false
    @Published var error: Error?
    @Published var activityIndicator = false
    
    private let networkService: LoginService
    private let tokenService: TokenService
    private let userService: UserDataServiceProtocol
    
    init(networkService: LoginService) {
        self.networkService = networkService
        self.tokenService = TokenKeychanService()
        self.userService = UserDataService()
    }
    
    func login(email: String, password: String) {
        self.updateActivityIndicator(state: true)
        let request = LoginRequest(email: email, password: password)
        networkService.login(request: request, handleResponse)
    }
    
    func signUp(email: String, password: String, confirmPassword: String) {
        self.updateActivityIndicator(state: true)
        let request = SignUpRequest(email: email, password: password,
                                    confirmPassword: confirmPassword)
        networkService.signUp(request: request, handleResponse)
    }
    
    private func handleResponse(response: Result<AuthResponse, Error>) {
        self.updateActivityIndicator(state: false)
        do {
            let response = try response.get()
            self.tokenService.save(accessToken: response.token)
            self.userService.setUser(response.user)
            DispatchQueue.main.async {
                self.success = true
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
}
