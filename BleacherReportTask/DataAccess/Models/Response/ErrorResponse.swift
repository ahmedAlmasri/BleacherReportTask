//
//  ErrorResponse.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import Foundation

struct ErrorResponse: Decodable {
    let code: Int
    let message: String
}
