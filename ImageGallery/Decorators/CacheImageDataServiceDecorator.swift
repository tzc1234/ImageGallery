//
//  CacheImageDataServiceDecorator.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 19/08/2022.
//

import Foundation

class CacheImageDataServiceDecorator: ImageDataService {
    private let service: ImageDataService
    private let cache: DataCacheManager
    
    init(service: ImageDataService, cache: DataCacheManager) {
        self.service = service
        self.cache = cache
    }
    
    func getImageData(imageId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let data = cache.getData(by: imageId) {
            completion(.success(data))
            return
        }
        
        service.getImageData(imageId: imageId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.cache.add(data: data, for: imageId)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
