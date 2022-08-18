//
//  HomeView.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel(
        service: PicsumAPI(
            client: URLSessionClient()))
    
    var body: some View {
        NavigationView {
            List(vm.images) { imageData in
                ImageRow(imageData: imageData)
                    .frame(height: UIScreen.main.bounds.width * 9/16)
            }
            .listStyle(.plain)
            .navigationTitle("Photos")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            vm.fetchImages()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
