//
//  ImageRow.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct ImageRow: View {
    @State private var image: UIImage?
    
    let loadImage: (@escaping (UIImage?) -> Void) -> Void
    let loadMoreImageModels: (() -> Void)?
    
    var body: some View {
        ZStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .scaleEffect(0.5)
            
            Image(uiImage: image ?? UIImage())
                .resizable()
        }
        .cornerRadius(20)
        .onAppear {
            loadImage { image = $0 }
            loadMoreImageModels?()
        }
    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow(loadImage: { _ in }, loadMoreImageModels: nil)
    }
}
