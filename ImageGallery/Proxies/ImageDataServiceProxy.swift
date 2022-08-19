//
//  ImageDataServiceProxy.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 19/08/2022.
//

import Foundation

class ImageDataServiceProxy: ImageDataService {
    private lazy var api: PicsumAPI = PicsumAPI(client: client)
    
    private let cache: DataCacheManager
    private let client: HttpClient
    
    init(cache: DataCacheManager, client: HttpClient) {
        self.cache = cache
        self.client = client
    }
    
    func getImageData(imageId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let data = cache.getData(by: imageId) {
            completion(.success(data))
            return
        }
        
        api.getImageData(imageId: imageId) { [weak self] result in
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
