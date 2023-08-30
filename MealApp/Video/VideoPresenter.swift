//
//  VideoPresenter.swift
//  MealApp
//
//  Created by Mine Rala on 28.08.2023.
//

import Foundation

protocol VideoPresenterProtocol: AnyObject {
    func load()
}

enum VideoPresenterOutput {
    case showVideo(String)
}

final class VideoPresenter: VideoPresenterProtocol {
    // MARK: Attributes
    private let view: VideoViewProtocol
    private let interactor: VideoInteractorProtocol
    private let router: VideoRouterProtocol
    private let videoUrl: String
    
    //MARK: Cons & Decons
    init(view: VideoViewProtocol, interactor: VideoInteractorProtocol, router: VideoRouterProtocol, videoUrl: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.videoUrl = videoUrl
        self.interactor.delegate = self
    }

    func load() {
        interactor.load(url: videoUrl)
    }
}

// MARK: - VideoInteractorDelegate
extension VideoPresenter: VideoInteractorDelegate {
    func handleOutput(_ output: VideoInteractorOutput) {
        switch output {
        case .showVideo(let string):
            view.handleOutput(.showVideo(string))
        }
    }
}
