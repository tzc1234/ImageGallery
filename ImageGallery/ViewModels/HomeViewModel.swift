//
//  HomeViewModel.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var images = [ImageModel]()
    @Published var showAlert = false
    @Published var shouldLoadMoreData = false
    
    private var page = 1
    private let totalPage = 34
    
    private let service: ImageService
    
    init(service: ImageService) {
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
    
    func loadMoreImages() {
        if shouldLoadMoreData {
            fetchImages()
            shouldLoadMoreData = false
        }
    }
    
}
