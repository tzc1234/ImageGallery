//
//  ImageDetailViewModel.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 20/08/2022.
//

import UIKit

final class ImageDetailViewModel: ObservableObject {
    @Published private(set) var image: UIImage?
    
    private let service: ImageDataService
    
    init(service: ImageDataService) {
        self.service = service
    }
    
    func getImage(imageModel: ImageModel) {
        service.getImageData(imageId: imageModel.id) { [weak self] result in
            switch result {
            case .success(let data):
                self?.image = UIImage(data: data)
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
}
