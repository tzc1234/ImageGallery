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
    
    @State var shouldLoadMoreData = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(zip(vm.images.indices, vm.images)), id: \.1.id) { index, imageData in
                    ImageRow(imageData: imageData, isLast: index == vm.images.count-1, shouldLoadMoreData: $shouldLoadMoreData)
                        .frame(height: UIScreen.main.bounds.width * 9/16)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Photos")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            vm.fetchImages()
        }
        .onChange(of: shouldLoadMoreData) { newValue in
            if newValue {
                vm.fetchImages()
                shouldLoadMoreData = false
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
