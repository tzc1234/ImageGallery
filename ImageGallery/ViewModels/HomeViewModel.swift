//
//  HomeViewModel.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var images = [ImageData]()
    private var page = 1
    private let totalPage = 34
    
    let service: ImageService
    
    init(service: ImageService) {
        self.service = service
    }
    
    func fetchImages() {
        guard page <= totalPage else { return }
        
        service.getImages(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self?.images += images
                    self?.page += 1
                case .failure(let error):
                    print(error.errorMessage)
                }
            }
        }
    }
    
}
