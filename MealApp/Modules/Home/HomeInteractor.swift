//
//  HomeInteractor.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    var delegate: HomeInteractorDelegate? { get set }
    func load() async
    func selectMeal(index: Int)
}

protocol HomeInteractorDelegate: AnyObject {
    func handleOutput(_ output: HomeInteractorOutput)
}

enum HomeInteractorOutput {
    case showMeals([Meal])
    case loadingIndicator(LoadingIndicatorMode)
    case showError(CustomError)
    case showMealDetails(String)
}


final class HomeInteractor: HomeInteractorProtocol {
    // MARK: Attributes
    public weak var delegate: HomeInteractorDelegate?
    private var list: [Meal] = []
    
    func load() async {
        await getMeals()
    }
    
    private func getMeals() async {
        delegate?.handleOutput(.loadingIndicator(.start))
        let response = await NetworkManager.shared.makeRequest(endpoint: .allMeals, method: .get, type: AllMeals.self)
        delegate?.handleOutput(.loadingIndicator(.stop))
        switch response {
        case .success(let success):
            self.list = success.meals
            delegate?.handleOutput(.showMeals(list))
        case .failure(let failure):
            delegate?.handleOutput(.showError(failure))
        }
    }
    
    func selectMeal(index: Int) {
        delegate?.handleOutput(.showMealDetails(list[index].id))
    }
}
