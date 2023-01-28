//
//  PhotosResponse+Dto.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

extension PhotosResponse {
    
    var toPhotoDtoList: PhotoDtoList {
        let photos = self.photos.photo.map({
            let url = "https://farm\($0.farm).static.flickr.com/\($0.server)/\($0.id)_\($0.secret)_w.jpg"
            let largeUrl = "https://farm\($0.farm).static.flickr.com/\($0.server)/\($0.id)_\($0.secret)_b.jpg"
            return PhotoDtoList.PhotoDto.init(smallUrl: URL(string: url), largeUrl: URL(string: largeUrl), title: $0.title)
        })
        
        return .init(pageInfo: .init(currentPage: UInt(self.photos.page), totalPages: self.photos.pages),
                     photos: photos)
    }
}
