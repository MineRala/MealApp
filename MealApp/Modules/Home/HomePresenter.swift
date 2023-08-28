//
//  HomePresenter.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func load()
    func selectMeal(index: Int)
}

enum HomePresenterOutput {
    case showMealList([Meal])
    case loadingIndicator(LoadingIndicatorMode)
    case showError(CustomError)
}

final class HomePresenter: HomePresenterProtocol {
    private let view: HomeViewProtocol
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    
    init(view: HomeViewProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
    
    func load() {
        Task {
            @MainActor in
            await interactor.load()
        }
    }
    
    func selectMeal(index: Int) {
        interactor.selectMeal(index: index)
    }
}

extension HomePresenter: HomeInteractorDelegate {
    func handleOutput(_ output: HomeInteractorOutput) {
        switch output {
        case .showMeals(let list):
            view.handleOutput(.showMealList(list))
        case .loadingIndicator(let indicatorMode):
            view.handleOutput(.loadingIndicator(indicatorMode))
        case .showError(let error):
            view.handleOutput(.showError(error))
        case .showMealDetails(let mealID):
            router.navigateToDetail(mealID: mealID, on: view)
        }
    }
}
