//
//  CacheConfig.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import Kingfisher

enum CacheConfig {
    static func configure() {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024
        cache.memoryStorage.config.countLimit = 100
        cache.memoryStorage.config.expiration = .seconds(600)
        cache.diskStorage.config.sizeLimit = 500 * 1024 * 1024
    }
}
