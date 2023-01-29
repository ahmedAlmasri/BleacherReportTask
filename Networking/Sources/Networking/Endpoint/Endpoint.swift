//
//  Endpoint.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

public protocol Endpoint: URLConvertible, URLRequestConvertible {
    var request: Request { get }
    var query: [URLQueryItem]? { get }
    var headers: [String: String] { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    
    func body() throws -> Data?
    func baseURL() throws -> URL
}

public extension Endpoint {
    var headers: [String: String] { [:] }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    var query: [URLQueryItem]? { nil }
    
    func body() throws -> Data? { nil }
}
