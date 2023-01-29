//
//  PhotosResponse+Dto.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

extension PhotosResponse {
    
    var toPhotoDtoList: PhotoDtoList {
        let photos = self.photos.photo.map {
            PhotoDtoList.PhotoDto(
                id: $0.id,
                smallUrl: $0.toImageUrl(ofSize: .small),
                largeUrl: $0.toImageUrl(ofSize: .large),
                title: $0.title
            )
        }
        
        return PhotoDtoList(
            pageInfo: PageInfo(currentPage: UInt(self.photos.page), totalPages: self.photos.pages),
            photos: photos
        )
    }
}

fileprivate extension PhotosResponse.ResponseBody.Photo {
    enum ImageSize: String {
        case small = "w"
        case large = "b"
    }
    
    func toImageUrl(ofSize size: ImageSize) -> URL? {
        URL(string: String(format: URLs.imagesUrl, farm, server, id, secret, size.rawValue))
    }
}
