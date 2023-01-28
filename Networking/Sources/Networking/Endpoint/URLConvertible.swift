//
//  URLConvertible.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

public protocol URLConvertible {
    func asURL() throws -> URL
}

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public extension URLConvertible where Self: Endpoint {
    
    func asURL() throws -> URL {
        var components = URLComponents()
        let base = try self.baseURL()
        components.scheme = base.scheme
        components.host = base.host
        components.queryItems = self.query
        components.path = self.request.path
        guard let url = components.url else { throw RequestError.invalidURL }
        return url
    }
}

public extension URLConvertible where Self: Endpoint {
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: try self.asURL())
        request.httpMethod = self.request.method
        request.allHTTPHeaderFields = self.headers
        if let body = try self.body() {
            request.httpBody = body
        }
        return request
    }
}
