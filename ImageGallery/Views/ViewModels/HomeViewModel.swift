//
//  HomeViewModel.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import UIKit

final class HomeViewModel: ObservableObject {
    @Published private(set) var images = [ImageModel]()
    @Published var showAlert = false
    
    private var page = 1
    private let totalPage = 34
    
    private let service: ImagesService
    
    init(service: ImagesService) {
        self.service = service
    }
    
    func fetchImages(refresh: Bool = false) {
        if refresh { resetPage() }
        
        guard page <= totalPage else { return }
        
        service.getImages(page: page) { [weak self] result in
            switch result {
            case .success(let images):
                self?.images += images
                self?.page += 1
            case .failure(let error):
                self?.showAlert = true
                print(error.errorMessage)
            }
        }
    }
    
    private func resetPage() {
        page = 1
        images = []
    }
    
    func loadImage(by imageModel: ImageModel) -> ((@escaping (UIImage?) -> Void) -> Void) {
        return { [weak self] completion in
            self?.service.getImageData(imageId: imageModel.id) { result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)!
                    completion(image)
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    
}
