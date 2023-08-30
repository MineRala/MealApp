//
//  DetailPresenter.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func load()
    func navigateToVideo()
}

enum DetailPresenterOutput {
    case showMeal(MealDetails)
    case loadingIndicator(LoadingIndicatorMode)
    case showError(CustomError)
}

final class DetailPresenter: DetailPresenterProtocol {
    // MARK: Attributes
    private let view: DetailViewProtocol
    private let interactor: DetailInteractorProtocol
    private let router: DetailRouterProtocol
    private let mealID: String
    
    //MARK: Cons & Decons
    init(view: DetailViewProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol, mealID: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.mealID = mealID
        self.interactor.delegate = self
    }
    
    func load() {
        Task {
            @MainActor in
            await interactor.load(id: mealID)
        }
    }
    
    func navigateToVideo() {
        interactor.navigateToVideo()
    }
}

// MARK: - DetailInteractorDelegate
extension DetailPresenter: DetailInteractorDelegate {
    func handleOutput(_ output: DetailInteractorOutput) {
        switch output {
        case .showMeal(let mealDetails):
            view.handleOutput(.showMeal(mealDetails))
        case .loadingIndicator(let indicatorMode):
            view.handleOutput(.loadingIndicator(indicatorMode))
        case .showError(let customError):
            view.handleOutput(.showError(customError))
        case .setVideo(let video):
            router.navigateToVideo(videoUrl: video, on: view)
        }
    }
}
