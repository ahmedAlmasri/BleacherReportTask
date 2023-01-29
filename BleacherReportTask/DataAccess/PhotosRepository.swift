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

struct PhotosRepositoryImpl: PhotosRepository {
    private let dataSource: PhotosDataSource
    
    init(dataSource: PhotosDataSource = PhotosDataSourceImpl()) {
        self.dataSource = dataSource
    }
    
    func search(query: SearchQuery) async throws -> PhotosResponse {
        do {
            return try await dataSource.search(query: query)
        } catch {
            throw RequestErrorMapper(error: error)
        }
    }
}
