//
//  MainQueueImageServiceDecorator.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 19/08/2022.
//

import Foundation

class MainQueueImageServiceDecorator: ImageService, ImageDataService {
    private let service: ImageService & ImageDataService
    
    init(service: ImageService & ImageDataService) {
        self.service = service
    }
    
    func getImages(page: Int, completion: @escaping (Result<[ImageModel], NetworkError>) -> Void) {
        service.getImages(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageModels):
                    completion(.success(imageModels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getImageData(imageId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        service.getImageData(imageId: imageId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
