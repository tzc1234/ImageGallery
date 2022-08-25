//
//  PreviewStubs.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 25/08/2022.
//

import Foundation

class PreviewStubs {
    static let instance = PreviewStubs()
    private init() {}
    
    let service = MainQueueDecorator(
        decoratee: PicsumAPIProxy(
            cache: NSDataCache.instance,
            client: HttpClientPreviewStub()
        )
    )
    
    lazy var homeViewModel = HomeViewModel(service: service)
    lazy var imageDetailViewModel = ImageDetailViewModel(service: service)
}

class HttpClientPreviewStub: HttpClient {
    let imageModels = [ImageModel(id: "id0", author: "Author0", width: 0, height: 0, url: "www.google.com", downloadURL: "")]
    
    func request(url: URL, method: HttpMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let data = try? JSONEncoder().encode(imageModels)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
}

extension ImageModel {
    static var preview: ImageModel {
        ImageModel(
            id: "id0",
            author: "Author Name",
            width: 1,
            height: 1,
            url: "www.google.com",
            downloadURL: "1"
        )
    }
}
