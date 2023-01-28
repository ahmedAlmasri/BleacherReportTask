//
//  Endpoint.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

public protocol Endpoint: URLConvertible, URLRequestConvertible {
    var request: Request { get }
    func body() throws -> Data?
    var query: [URLQueryItem]? { get }
    var headers: [String: String] { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    func baseURL() throws -> URL
    
}

public extension Endpoint {
    var headers: [String: String] { [:] }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    func body() throws -> Data? { nil }
    var query: [URLQueryItem]? { nil }
}
