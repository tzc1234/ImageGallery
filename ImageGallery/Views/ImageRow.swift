//
//  ImageRow.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct ImageRow: View {
    
    @StateObject private var vm = ImageRowViewModel(
        service: PicsumAPI(
            client: URLSessionClient()),
        cacheManager: MainImageCacheManager.instance)
    
    let imageModel: ImageModel
    let isLast: Bool
    @Binding var shouldLoadMoreData: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .scaleEffect(0.5)
            
            Image(uiImage: vm.image ?? UIImage())
                .resizable()
        }
        .cornerRadius(20)
        .onAppear {
            vm.getImage(imageModel: imageModel)
            
            if isLast {
                shouldLoadMoreData = true
            }
        }

    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow(
            imageModel:
                ImageModel(
                    id: "1",
                    author: "1",
                    width: 1,
                    height: 1,
                    url: "1",
                    downloadURL: "1"),
            isLast: false,
            shouldLoadMoreData: .constant(false)
        )
    }
}
