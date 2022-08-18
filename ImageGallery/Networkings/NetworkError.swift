//
//  NetworkError.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case flickrError(code: Int, message: String)
    case invalidServerResponse
    case unspecified(error: Error)
    case noData
    case dataDecodeFailure(error: DecodingError)
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .flickrError(let code, let message):
            return "Code: \(code), \(message)"
        case .invalidServerResponse:
            return "Invalid server response."
        case .unspecified(let error):
            return error.localizedDescription
        case .noData:
            return "No Data."
        case .dataDecodeFailure(let error):
            return "\(error)"
        }
    }
}
