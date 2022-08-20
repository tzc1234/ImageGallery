//
//  ImageRow.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct ImageRow: View {
    @StateObject private var vm = ImageRowViewModel(
        service: MainQueueDecorator(
            decoratee: ImageDataServiceProxy(
                cache: MainDataCacheManager.instance,
                client: URLSessionClient()
            )
        )
    )
    
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
            imageModel: ImageModel.dummy,
            isLast: false,
            shouldLoadMoreData: .constant(false)
        )
    }
}
