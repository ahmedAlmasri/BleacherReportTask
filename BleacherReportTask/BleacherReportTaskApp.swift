//
//  BleacherReportTaskApp.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import SwiftUI

@main
struct BleacherReportTaskApp: App {
    
    init() {
        CacheConfig.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SearchPhotoScreen()
        }
    }
}
