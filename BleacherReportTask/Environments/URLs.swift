//
//  URLs.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import Foundation

enum URLs {
    @XcodeConfig(key: "API_URL") static var apiUrl: String
    @XcodeConfig(key: "IMAGES_URL") static var imagesUrl: String
}
