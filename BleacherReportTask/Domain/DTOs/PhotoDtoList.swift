//
//  PhotoDtoList.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

struct PhotoDtoList: Equatable {
    let pageInfo: PageInfo
    let photos: [PhotoDto]
}

extension PhotoDtoList {
    struct PhotoDto: Identifiable, Equatable {
        let id: String
        let smallUrl: URL?
        let largeUrl: URL?
        let title: String
    }
}

#if DEBUG
extension PhotoDtoList.PhotoDto {
    static var preview: Self {
        .init(
            id: "1",
            smallUrl: URL(string: "https://live.staticflickr.com/65535/52654287870_38568be027_m.jpg"),
            largeUrl: URL(string: "https://live.staticflickr.com/65535/52654287870_38568be027_b.jpg"),
            title: "test preview title"
        )
    }
}
#endif
