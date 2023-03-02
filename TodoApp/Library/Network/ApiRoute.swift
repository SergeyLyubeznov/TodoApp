//
//  ApiRoute.swift
//  NetworkService
//
//  Created by Serhii Liubeznov on 25.02.2023.
//

import Foundation

enum ApiRoute {
    case tasks
    case taskDelete(id: String)
    
    case signUp
    case login
    
    var path: String {
        switch self {
        case .tasks:
            return Constants.Api.Tasks
        case .taskDelete(id: let id):
            return "\(Constants.Api.Tasks)/\(id)"
        case .signUp:
            return Constants.Api.SignUp
        case .login:
            return Constants.Api.Login
        }
    }
}

extension ApiRoute {
    func request(host: ApiHost,
                 method: HTTPMethod = .GET,
                 parameters: [String: Any] = [:],
                 body: Data? = nil,
                 headers: [String: String] = [:]) -> URLRequest {
        
        guard let url = URL(string: "\(host.host)/\(path)") else {
            preconditionFailure("Url mustbe not nil")
        }
        
        let request = ApiRequest(url: url)
        if !parameters.isEmpty {
            request.setParameters(parameters)
        }
        
        if !headers.isEmpty {
            request.setHeaders(headers)
        }
        
        request.setMethod(method)
        request.setBody(body)
    
        return request.build()
    }
}
