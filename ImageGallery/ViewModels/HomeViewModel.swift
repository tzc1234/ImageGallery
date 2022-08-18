//
//  HomeViewModel.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var images = [ImageData]()
    
    let service: ImageService
    
    init(service: ImageService) {
        self.service = service
    }
    
    func fetchImages() {
        service.getImages(page: 1) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self?.images += images
                case .failure(let error):
                    print(error.errorMessage)
                }
            }
        }
    }
    
}
