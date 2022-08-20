//
//  ImageModel.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import Foundation

struct ImageModel: Codable, Identifiable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
    
    static var dummy: ImageModel {
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
