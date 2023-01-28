//
//  HttpClientTests.swift
//
//
//  Created by Ahmad Almasri on 26/01/2023.
//
import XCTest
@testable import Networking

final class HttpClientTests: XCTestCase {
    
    func test_success_empty_body() async throws {
        let url = try MockEndPoint.get.baseURL()
        let mockSession = createSession(url: url, statusCode: 200, body: Data(), error: nil)
        let http = HttpClient(session: mockSession)
        let result = try await http.request(endpoint: MockEndPoint.get)
        XCTAssertEqual(200, result.urlResponse.statusCode)
    }
    
    func test_success_body() async throws {
        let mockResults = [MockResult(id: 1, name: "user1"), MockResult(id: 2, name: "user2")]
        let body = try JSONEncoder().encode(mockResults)
        let url = try MockEndPoint.get.baseURL()
        let mockSession = createSession(url: url, statusCode: 200, body: body, error: nil)
        let http = HttpClient(session: mockSession)
        let result: [MockResult] = try await http.request(endpoint:  MockEndPoint.get, decoder: JSONDecoder.default)
        XCTAssertEqual(mockResults, result)
    }
    
    func test_failure_400_status_code() async throws {
        let url = try MockEndPoint.get.baseURL()
        let mockSession = createSession(url: url, statusCode: 400, body: Data(), error: nil)
        let http = HttpClient(session: mockSession)
        await XCTAssertThrowsError(try await http.request(endpoint:  MockEndPoint.get)) { error in
            guard let error = error as? RequestError else {
                XCTFail("the error should be RequestError type")
                return
            }
            switch error {
                case let .inlineError(_, response):
                    XCTAssertEqual(400, response.statusCode)
                default:
                    XCTFail("the error should be inlineError with response date")
            }
            
        }
    }
    
    func test_failure_decodable() async throws {
        let mockResults = [MockResult(id: 1, name: "user1"), MockResult(id: 2, name: "user2")]
        let body = try JSONEncoder().encode(mockResults)
        let url = try MockEndPoint.get.baseURL()
        let mockSession = createSession(url: url, statusCode: 200, body: body, error: nil)
        let http = HttpClient(session: mockSession)
        do {
            let _: [MockFailureResult] = try await http.request(endpoint:  MockEndPoint.get, decoder: JSONDecoder.default)
            XCTFail("this request should fail with decoding error")
        } catch {
            guard let error = error as? DecodingError else {
                XCTFail("he error should be DecodingError type")
                return
            }
            switch error {
                case let .keyNotFound(key, _):
                    XCTAssertEqual(key.stringValue, "age")
                default:
                    XCTFail("he error should be keyNotFound with key name")
            }
        }
    }
    
    private func createSession(url: URL, statusCode: Int, body: Data, error: Error?) -> URLSession {
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        URLProtocolMock.mockURLs = [url.host: (error, body, response)]
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        
        return URLSession(configuration: sessionConfiguration)
    }
}
