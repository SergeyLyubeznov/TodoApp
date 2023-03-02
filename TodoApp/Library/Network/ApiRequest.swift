//
//  ApiRequest.swift
//  NetworkService
//
//  Created by Serhii Liubeznov on 25.02.2023.
//

import Foundation

protocol ApiRequestProtocol {
    init(url: URL)
    func setMethod(_ method: HTTPMethod)
    func setBody(_ body: Data?)
    func setParameters(_ parameters: [String: Any])
    func setHeaders(_ headers: [String: String])
    func build() -> URLRequest
}

class ApiRequest: ApiRequestProtocol {
    
    private var request: URLRequest
    private var url: URL
    
    required init(url: URL) {
        self.url = url
        self.request = URLRequest(url: url)
    }
    
    func setMethod(_ method: HTTPMethod) {
        request.httpMethod = method.rawValue
    }
    
    func setParameters(_ parameters: [String: Any]) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
        self.request.url = components?.url
    }
    
    func setHeaders(_ headers: [String: String]) {
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func setBody(_ body: Data?) {
        request.httpBody = body
        if let body = body {
            request.setValue("\(body.count)", forHTTPHeaderField: "Content-Lengh")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
    
    func build() -> URLRequest {
        return request
    }
}
