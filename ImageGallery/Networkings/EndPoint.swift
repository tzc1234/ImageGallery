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
    var queryItems: [URLQueryItem]? { get }
    var method: String { get }
}

enum PicsumEndPoint: EndPoint {
    case listImages(page: Int)
    case imageData(imageModel: ImageModel)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "picsum.photos"
        }
    }
    
    var path: String {
        switch self {
        case .listImages:
            return "/v2/list"
        case .imageData(let imageModel):
            return "/id/\(imageModel.id)/390/219"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "get"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .listImages(let page):
            return [
                .init(name: "page", value: "\(page)")
            ]
        case .imageData:
            return nil
        }
    }

}
