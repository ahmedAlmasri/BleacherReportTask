//
//  PhotosRepository.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

protocol PhotosRepository {
    func search(query: SearchQuery) async throws -> PhotosResponse
}

struct PhotosRepositoryImpt: PhotosRepository {
    let dataSource: PhotosDataSource
    
    init(dataSource: PhotosDataSource = PhotosDataSourceImpt()) {
        self.dataSource = dataSource
    }
    
    func search(query: SearchQuery) async throws -> PhotosResponse {
        try await dataSource.search(query: query)
    }
}
