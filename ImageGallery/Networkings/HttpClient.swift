//
//  HttpClient.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

protocol HttpClient {
    func request(url: URL, method: HttpMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class URLSessionClient: HttpClient {
    func request(url: URL, method: HttpMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: completion)
        dataTask.resume()
    }
}
