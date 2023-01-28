//
//  SearchDataSource.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation
import Networking

protocol PhotosDataSource {
    func search(query: SearchQuery) async throws -> PhotosResponse
}

struct PhotosDataSourceImpt: PhotosDataSource {
    let httpClient: Networkable
    
    init(httpClient: Networkable = HttpClient()) {
        self.httpClient = httpClient
    }
    
    func search(query: SearchQuery) async throws -> PhotosResponse {
        try await httpClient.request(endpoint: SearchPhotosEndpoint.search(query: query), decoder: .default)
    }
}
