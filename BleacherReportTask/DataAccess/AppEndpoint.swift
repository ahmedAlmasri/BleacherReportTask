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
        URL(string: "https://www.flickr.com")!
    }
}
