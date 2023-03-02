//
//  NetworkService.swift
//  NetworkService
//
//  Created by Serhii Liubeznov on 25.02.2023.
//

import Foundation

enum HTTPMethod: String {
    case POST
    case PUT
    case GET
    case DELETE
}

enum ApiEnvironment {
    case production
    
    var host: String {
        switch self {
        case .production:
            return Constants.Api.Host
        }
    }
}

struct ApiHost {
    let host: String
    let environment: ApiEnvironment
    
    init(environment: ApiEnvironment) {
        self.host = environment.host
        self.environment = environment
    }
}

protocol NetworkServiceProtocol {
    func get(route: ApiRoute, parameters: [String: Any],
             completion: @escaping (Result<Data, Error>) -> Void)
    func post(route: ApiRoute, body: Data?, headers: [String: String], completion: @escaping (Result<Data, Error>) -> Void)
}

protocol NetworkAccessToken {
    func addAuthTokenIfNeed(request: URLRequest) -> URLRequest
}

class NetworkService {
    
    typealias HttpHeaders = [String: String]
    
    var accessTokenType: AccessTokenType {.bearer}
    
    private let host: ApiHost
    private let session: URLSession
    private var accessToken: String?
    
    init(host: ApiHost = ApiHost(environment: .production),
         accessToken: String? = nil) {
        self.host = host
        self.session = URLSession.shared
        self.accessToken = accessToken
    }
    
    func setAccesToken(_ token: String) {
        self.accessToken = token
    }
}

extension NetworkService: NetworkAccessToken {
    
    enum AccessTokenType: String {
        case bearer = "Bearer"
        case basic = "Basic"
    }
    
    func addAuthTokenIfNeed(request: URLRequest) -> URLRequest {
        
        var request = request
        if let token = accessToken {
            let value = "\(accessTokenType.rawValue) \(token)"
            request.addValue(value, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func get<T: Decodable>(route: ApiRoute, parameters: [String: Any] = [:],
                           completion: @escaping (Result<T, Error>) -> Void) {
        let request = route.request(host: self.host, parameters: parameters)
        self.execute(request: request, completion: completion)
    }
    
    func post<T: Decodable>(route: ApiRoute, body: Data? = nil, headers: [String: String] = [:],
                            completion: @escaping (Result<T, Error>) -> Void) {
        let request = route.request(host: self.host, method: .POST, body: body, headers: headers)
        self.execute(request: request, completion: completion)
    }
    
    func delete<T: Decodable>(route: ApiRoute, body: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let request = route.request(host: self.host, method: .DELETE)
        self.execute(request: request, completion: completion)
    }
    
    private func execute<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let request = addAuthTokenIfNeed(request: request)
        
        session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Response nil", code: 0)))
                return
            }
            
            if (200...299).contains(response.statusCode), let data = data {
                
                do {
                    let item = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(item))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "Error", code: response.statusCode)))
            }
            
        }.resume()
    }
}
