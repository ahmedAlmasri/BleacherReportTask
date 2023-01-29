//
//  RequestError.swift
//  
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

public enum RequestError: LocalizedError {
    case invalidURL
    case noResponse
    case inlineError(Data, HTTPURLResponse)
    case decodingError(Error, Data, HTTPURLResponse)
}
