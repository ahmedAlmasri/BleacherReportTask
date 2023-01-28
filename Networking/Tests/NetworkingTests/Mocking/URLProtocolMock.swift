//
//  URLProtocolMock.swift
//  
//
//  Created by Ahmad Almasri on 26/01/2023.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var mockURLs = [String?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let (error, data, response) = URLProtocolMock.mockURLs[url.host] {
                
                if let responseStrong = response {
                    self.client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
                }
                
                if let dataStrong = data {
                    self.client?.urlProtocol(self, didLoad: dataStrong)
                }
                
                if let errorStrong = error {
                    self.client?.urlProtocol(self, didFailWithError: errorStrong)
                }
            }
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // Required to be implemented. Do nothing here.
    }
}
