//
//  Request.Endpoint.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

// Endpoint is a combination of HTTPMethod and Path.
public enum Request {
    case get(path: String)
    
    internal var path: String {
        switch self {
            case .get(let path):
            return path
        }
    }
    
    internal var method: String {
        switch  self {
        case .get:
            return "GET"
        }
    }
}
