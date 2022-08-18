//
//  HomeView.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List(0..<20) { _ in
                ImageRow()
                    .frame(height: UIScreen.main.bounds.width * 9/16)
            }
            .listStyle(.plain)
            .navigationTitle("Photos")
        }
        .navigationViewStyle(.stack)
//        .onAppear {
//            PicsumAPI(client: URLSessionClient()).getImages(page: 1) { result in
//                switch result {
//                case .success(let images):
//                    print(images)
//                case .failure(let error):
//                    print(error.errorMessage)
//                }
//            }
//        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
