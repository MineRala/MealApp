//
//  DetailInteractor.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    var delegate: DetailInteractorDelegate? { get set }
    func load(id: String) async
    func navigateToVideo()
}

protocol DetailInteractorDelegate: AnyObject {
    func handleOutput(_ output: DetailInteractorOutput)
}

enum DetailInteractorOutput {
    case showMeal(MealDetails)
    case showError(CustomError)
    case setVidoe(String)
}


final class DetailInteractor: DetailInteractorProtocol {
    public weak var delegate: DetailInteractorDelegate?
    private var details: MealDetails?
  
    func load(id: String) async {
        let response = await NetworkManager.shared.makeRequest(endpoint: .mealDetails(id: id), method: .get, type: Meals.self)
        switch response {
        case .success(let success):
            details = success.meals.first
            if let details = details {
                delegate?.handleOutput(.showMeal(details))
            }
        case .failure(let failure):
            delegate?.handleOutput(.showError(failure))
        }
    }
    
    func navigateToVideo() {
        if let details = details {
            delegate?.handleOutput(.setVidoe(details.youtubeUrl))
        }
    }
}
