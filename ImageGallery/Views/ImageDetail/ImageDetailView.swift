//
//  ImageDetailView.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 20/08/2022.
//

import SwiftUI

struct ImageDetailView: View {
    @StateObject var vm: ImageDetailViewModel
    let imageModel: ImageModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .scaleEffect(0.5)
                    
                    Image(uiImage: vm.image ?? UIImage())
                        .resizable()
                        .onAppear {
                            vm.getImage(imageModel: imageModel)
                        }
                }
                .frame(height: geo.size.width * 9/16)
                
                VStack {
                    Text(imageModel.author)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                    
                    Link(imageModel.url, destination: URL(string: imageModel.url)!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption.weight(.semibold))
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("Image Detail")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(vm: PreviewStubs.instance.imageDetailViewModel, imageModel: ImageModel.preview)
    }
}
