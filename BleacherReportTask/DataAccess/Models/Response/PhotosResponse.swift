//
//  PhotosResponse.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

struct PhotosResponse: Decodable {
    let photos: ResponseBody
}

extension PhotosResponse {
    struct ResponseBody: Decodable {
        let page: UInt
        let pages: UInt
        let total: UInt
        let photo: [Photo]
    }
}

extension PhotosResponse.ResponseBody {
    struct Photo: Decodable {
        let id: String
        let owner: String
        let secret: String
        let server: String
        let farm: Int
        let title: String
        let ispublic: Int
        let isfriend: Int
        let isfamily: Int
    }
}
