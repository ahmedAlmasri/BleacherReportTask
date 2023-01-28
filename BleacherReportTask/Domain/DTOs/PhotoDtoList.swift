//
//  PhotoDtoList.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

struct PhotoDtoList {
    let pageInfo: PageInfo
    let photos: [PhotoDto]
    
    struct PhotoDto {
        let smallUrl: URL?
        let largeUrl: URL?
        let title: String
    }
}
