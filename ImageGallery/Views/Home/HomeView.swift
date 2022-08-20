//
//  HomeView.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel(
        service: MainQueueDecorator(
            decoratee: PicsumAPIProxy(
                cache: MainDataCacheManager.instance,
                client: URLSessionClient()
            )
        )
    )
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(zip(vm.images.indices, vm.images)), id: \.1.id) { index, imageModel in
                    NavigationLink {
                        ImageDetailView(imageModel: imageModel)
                    } label: {
                        ImageRow(
                            loadImage: vm.loadImage(by: imageModel),
                            loadMoreImageModels: index == vm.images.count-1 ? { vm.fetchImages() } : nil
                        )
                        .frame(height: UIScreen.main.bounds.width * 9/16)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Photos")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            vm.fetchImages()
        }
        .alert(isPresented: $vm.showAlert) {
            Alert(
                title: Text("Network Error."),
                message: Text("Please try again later."),
                primaryButton: .default(
                    Text("Refresh"),
                    action: {
                        vm.fetchImages(refresh: true)
                    }
                ),
                secondaryButton: .cancel()
            )
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
