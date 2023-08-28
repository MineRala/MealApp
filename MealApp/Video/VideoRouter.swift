//
//  VideoRouter.swift
//  MealApp
//
//  Created by Mine Rala on 28.08.2023.
//

import Foundation

protocol VideoRouterProtocol: AnyObject {
    
}

final class VideoRouter: VideoRouterProtocol {
    static func build(url: String) -> VideoViewProtocol {
        let view: VideoViewProtocol = VideoViewController()
        let interactor: VideoInteractorProtocol = VideoInteractor()
        let router: VideoRouterProtocol = VideoRouter()
        let presener: VideoPresenterProtocol = VideoPresenter(view: view, interactor: interactor, router: router, videoUrl: url)
        view.presenter = presener
        return view
    }
}
