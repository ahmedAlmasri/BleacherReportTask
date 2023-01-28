//
//  MockResult.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

struct MockResult: Codable, Equatable {
    let id: Int
    let name: String
}

struct MockFailureResult: Codable, Equatable {
    let id: Int
    let name: String
    let age: Int
}
