//
//  MainQueueDecorator.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 19/08/2022.
//

import Foundation

class MainQueueDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
}

extension MainQueueDecorator: ImageService where T: ImageService {
    func getImages(page: Int, completion: @escaping (Result<[ImageModel], NetworkError>) -> Void) {
        decoratee.getImages(page: page) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

extension MainQueueDecorator: ImageDataService where T: ImageDataService {
    func getImageData(imageId: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        decoratee.getImageData(imageId: imageId) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
