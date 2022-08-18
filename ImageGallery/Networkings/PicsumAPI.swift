//
//  PicsumAPI.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

protocol HttpClient {
    func request(url: URL, method: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class URLSessionClient: HttpClient {
    func request(url: URL, method: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: completion)
        dataTask.resume()
    }
}

class PicsumAPI {
    let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func getImages(page: Int, completion: @escaping (Result<[ImageData], NetworkError>) -> Void) {
        let ep = PicsumEndPoint.listImages(page: page)
        
        guard let url = getURL(by: ep) else {
            completion(.failure(.invalidURL))
            return
        }
        
        requestData(url: url, method: ep.method) { result in
            switch result {
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode([ImageData].self, from: data)
                    completion(.success(images))
                } catch {
                    completion(.failure(NetworkError.unspecified(error: error)))
                }
            case .failure(let error):
                completion(.failure(NetworkError.unspecified(error: error)))
            }
        }
    }
    
    func requestData(url: URL, method: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        print("URL: \(url)")
        
        client.request(url: url, method: method) { data, response, error in
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
