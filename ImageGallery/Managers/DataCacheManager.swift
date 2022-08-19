//
//  DataCacheManager.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

protocol DataCacheManager {
    func add(data: Data, for key: String)
    func getData(by key: String) -> Data?
}

class MainDataCacheManager: DataCacheManager {
    static let instance = MainDataCacheManager()
    private init() {}
    
    private var cache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.countLimit = 100
        cache.totalCostLimit = 50_000_000 // 50 megabytes
        return cache
    }()
    
    func add(data: Data, for key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func getData(by key: String) -> Data? {
        cache.object(forKey: key as NSString) as? Data
    }
}
