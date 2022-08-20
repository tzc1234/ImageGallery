//
//  ImageDetailView.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 20/08/2022.
//

import SwiftUI

struct ImageDetailView: View {
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
                    
                    Image(uiImage: UIImage())
                        .resizable()
                }
                .frame(height: geo.size.width * 9/16)
                
                VStack {
                    Text(imageModel.author)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                    
                    Text(imageModel.url)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                }
                .padding(.horizontal)
                
            }
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(imageModel: ImageModel.dummy)
    }
}
