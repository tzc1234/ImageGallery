//
//  ImageCacheManager.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import UIKit

protocol ImageCacheManager {
    func add(image: UIImage, for key: String)
    func remove(for key: String)
    func getImage(by key: String) -> UIImage?
}

class MainImageCacheManager: ImageCacheManager {
    static let instance = MainImageCacheManager()
    private init() {}
    
    private var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 50_000_000 // 50 megabytes
        return cache
    }()
    
    func add(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func remove(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func getImage(by key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}
