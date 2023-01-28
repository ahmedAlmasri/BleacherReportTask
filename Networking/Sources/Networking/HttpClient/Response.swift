//
//  Response.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

public struct Response {
    public let body: Data
    public let urlResponse: HTTPURLResponse
    public let request: URLRequest
}
