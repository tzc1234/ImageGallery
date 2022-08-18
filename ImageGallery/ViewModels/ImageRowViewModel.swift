//
//  ImageRowViewModel.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation
import UIKit

class ImageRowViewModel: ObservableObject {
    @Published var image: UIImage?
    
    private let service: ImageDataService
    private let cacheManager: ImageCacheManager
    
    init(service: ImageDataService, cacheManager: ImageCacheManager) {
        self.service = service
        self.cacheManager = cacheManager
    }
    
    func getImage(imageData: ImageData) {
        if let image = cacheManager.getImage(by: imageData.id) {
            self.image = image
            return
        }
        
        service.getImageData(imageData: imageData) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        self?.cacheManager.add(image: image, for: imageData.id)
                        self?.image = image
                    }
                case .failure(let error):
                    print(error.errorMessage)
                }
            }
            
        }
    }
    
}
