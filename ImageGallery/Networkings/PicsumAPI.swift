//
//  PicsumAPI.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

protocol ImageService {
    func getImages(page: Int, completion: @escaping (Result<[ImageModel], NetworkError>) -> Void)
}

protocol ImageDataService {
    func getImageData(imageModel: ImageModel, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class PicsumAPI: ImageService, ImageDataService {
    private let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func getImages(page: Int, completion: @escaping (Result<[ImageModel], NetworkError>) -> Void) {
        requestData(endPoint: .listImages(page: page)) { result in
            switch result {
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode([ImageModel].self, from: data)
                    completion(.success(images))
                } catch {
                    completion(.failure(NetworkError.unspecified(error: error)))
                }
            case .failure(let error):
                completion(.failure(NetworkError.unspecified(error: error)))
            }
        }
    }
    
    func getImageData(imageModel: ImageModel, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        requestData(endPoint: .imageData(imageModel: imageModel), completion: completion)
    }
    
    private func requestData(endPoint: PicsumEndPoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = getURL(by: endPoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        client.request(url: url, method: endPoint.method) { data, response, error in
            guard error == nil else {
                completion(.failure(.unspecified(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidServerResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
    }
    
    private func getURL(by endPoint: EndPoint) -> URL? {
        var components = URLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.baseURL
        components.path = endPoint.path
        components.queryItems = endPoint.queryItems
        return components.url
    }
}
