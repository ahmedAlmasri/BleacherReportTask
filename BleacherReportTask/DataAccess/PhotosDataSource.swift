//
//  PhotosDataSource.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation
import Networking

protocol PhotosDataSource {
    func search(query: SearchQuery) async throws -> PhotosResponse
}

struct PhotosDataSourceImpl: PhotosDataSource {
    private let httpClient: Networkable
    
    init(httpClient: Networkable = HttpClient()) {
        self.httpClient = httpClient
    }
    
    func search(query: SearchQuery) async throws -> PhotosResponse {
        try await httpClient.request(endpoint: PhotosEndpoint.search(query: query), decoder: .default)
    }
}
