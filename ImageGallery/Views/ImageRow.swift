//
//  ImageRow.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct ImageRow: View {
    var body: some View {
        ZStack {
            Color.green
            
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .scaleEffect(0.5)
            
            Image(uiImage: UIImage())
                .resizable()
        }
        .cornerRadius(20)

    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow()
    }
}
