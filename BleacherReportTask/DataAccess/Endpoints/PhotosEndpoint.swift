//
//  PhotosEndpoint.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation
import Networking

enum PhotosEndpoint: Endpoint {
    case search(query: SearchQuery)
    
    var request: Networking.Request {
        switch self {
            case .search:
                return .get(path: "/services/rest")
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
            case let .search(query):
                return [
                    .init(name: "method", value: "flickr.photos.search"),
                    .init(name: "api_key", value: "1508443e49213ff84d566777dc211f2a"),
                    .init(name: "format", value: "json"),
                    .init(name: "nojsoncallback", value: "1"),
                    .init(name: "per_page", value: "\(query.perPage)"),
                    .init(name: "page", value: "\(query.page)"),
                    .init(name: "text", value: "\(query.text)")
                ]
        }
    }
}
