//
//  AppEndpoint.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation
import Networking

extension Endpoint {
    func baseURL() throws -> URL {
        guard let url = URL(string: URLs.apiUrl) else {
            throw RequestError.invalidURL
        }
        
        return url
    }
}
