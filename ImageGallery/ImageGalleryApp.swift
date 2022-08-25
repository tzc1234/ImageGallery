//
//  ImageGalleryApp.swift
//  ImageGallery
//
//  Created by Tsz-Lung on 18/08/2022.
//

import SwiftUI

@main
struct ImageGalleryApp: App {
    let homeViewHierarchyFactory = HomeViewHierarchyFactory()
    
    var body: some Scene {
        WindowGroup {
            homeViewHierarchyFactory.showHome()
        }
    }
}

// MARK: - View Factory
class HomeViewHierarchyFactory {
    private lazy var service = MainQueueDecorator(
        decoratee: PicsumAPIProxy(
            cache: NSDataCache.instance,
            client: URLSessionClient()
        )
    )
    
    func showHome() -> HomeView {
        HomeView(vm: HomeViewModel(service: self.service), viewFactory: self)
    }
    
    func showImageDetail(by imageModel: ImageModel) -> ImageDetailView {
        ImageDetailView(vm: ImageDetailViewModel(service: self.service), imageModel: imageModel)
    }
}

protocol HomeToOtherViewFactory: AnyObject {
    func showImageDetail(by imageModel: ImageModel) -> ImageDetailView
}

extension HomeViewHierarchyFactory: HomeToOtherViewFactory {}
