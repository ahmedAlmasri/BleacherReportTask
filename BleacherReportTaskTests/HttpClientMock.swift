//
//  HttpClientMock.swift
//  BleacherReportTaskTests
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import Foundation
import Networking
import XCTest

final class HttpClientMock: Networkable {
    var responseResult: Result<Response, Error> = .failure(MockError.valueNotSet)
    func request(endpoint: Endpoint) async throws -> Response {
        try responseResult.get()
    }
    
    var decodableResult: Result<Decodable, Error> = .failure(MockError.valueNotSet)
    func request<T: Decodable>(endpoint: Endpoint, decoder: JSONDecoder) async throws -> T {
        do {
            let value = try decodableResult.get()
            return try XCTUnwrap(value as? T)
        } catch {
            throw error
        }
    }
}
