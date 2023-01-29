//
//  SearchPhotosUseCase.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

struct SearchPhotosUseCase {
    private let repository: PhotosRepository
    
    init(repository: PhotosRepository = PhotosRepositoryImpl()) {
        self.repository = repository
    }
    
    func call(keyword: String, page: UInt) async throws -> PhotoDtoList {
        try await repository
            .search(query: SearchQuery(perPage: 50, page: page, text: keyword))
            .toPhotoDtoList
    }
}
