//
//  HttpClient.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

public protocol Networkable {
    func request(endpoint: Endpoint) async throws -> Response
    func request<T: Decodable>(endpoint: Endpoint, decoder: JSONDecoder) async throws -> T
}

public final class HttpClient: Networkable {
    private let session: URLSession
    // Range success http status code ref: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
    private let successRange = (200 ... 299)
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request(endpoint: Endpoint) async throws -> Response {
        let urlRequest = try endpoint.asURLRequest()
        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.noResponse
        }
        switch response.statusCode {
        case successRange:
            return .init(body: data, urlResponse: response, request: urlRequest)
        default:
               throw RequestError.inlineError(data, response)
        }
    }
    
    public func request<T>(endpoint: Endpoint, decoder: JSONDecoder = .default) async throws -> T where T : Decodable {
        let response = try await request(endpoint: endpoint)
        return try decoder.decode(T.self, from: response.body)
    }
}
