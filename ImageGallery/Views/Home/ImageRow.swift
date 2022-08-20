//
//  ImageRow.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct ImageRow: View {
    @State private var image: UIImage?
    
    let imageModel: ImageModel
    let isLast: Bool
    @Binding var shouldLoadMoreData: Bool
    let loadImage: ((String, @escaping (UIImage?) -> Void) -> Void)
    
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
            loadImage(imageModel.id) { image in
                self.image = image
            }
            
            if isLast {
                shouldLoadMoreData = true
            }
        }

    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow(
            imageModel: ImageModel.dummy,
            isLast: false,
            shouldLoadMoreData: .constant(false),
            loadImage: { _,_ in }
        )
    }
}
