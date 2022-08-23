//
//  PicsumAPIProxy.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 19/08/2022.
//

import Foundation

class PicsumAPIProxy {
    private lazy var api: PicsumAPI = PicsumAPI(client: client)
    
    private let cache: DataCache
    private let client: HttpClient
    
    init(cache: DataCache, client: HttpClient) {
        self.cache = cache
        self.client = client
    }
}

extension PicsumAPIProxy: ImageDataService {
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

extension PicsumAPIProxy: ImageService {
    func getImages(page: Int, completion: @escaping (Result<[ImageModel], NetworkError>) -> Void) {
        api.getImages(page: page, completion: completion)
    }
}
