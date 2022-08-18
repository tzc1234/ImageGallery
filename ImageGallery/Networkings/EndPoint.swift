//
//  EndPoint.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

protocol EndPoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: String { get }
}

enum PicsumEndPoint: EndPoint {
    case listImages(page: Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        case .listImages:
            return "picsum.photos"
        }
    }
    
    var path: String {
        switch self {
        case .listImages:
            return "/v2/list"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "get"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .listImages(let page):
            return [
                .init(name: "page", value: "\(page)")
            ]
        }
    }

}
