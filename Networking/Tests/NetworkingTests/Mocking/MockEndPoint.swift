//
//  MockEndPoint.swift
//  
//
//  Created by Ahmad Almasri on 26/01/2023.
//

import Foundation
import Networking

enum MockEndPoint {
    case get
    case users
}
extension MockEndPoint: Endpoint {
    var request: Request {
        switch self {
        case .get:
            return Request.get(path: "/")
        case .users:
            return Request.get(path: "/users")
        }
        
    }
    
    func baseURL() throws -> URL {
        
        return URL(string:  "https://mock.com")!
    }
    
    var prefix: String { "" }
}
