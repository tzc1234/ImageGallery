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
                ForEach(Array(zip(vm.images.indices, vm.images)), id: \.1.id) { index, imageModel in
                    ImageRow(
                        imageModel: imageModel,
                        isLast: index == vm.images.count-1,
                        shouldLoadMoreData: $shouldLoadMoreData
                    )
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
