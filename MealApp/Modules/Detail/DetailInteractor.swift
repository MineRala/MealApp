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
    case loadingIndicator(LoadingIndicatorMode)
    case showError(CustomError)
    case setVideo(String)
}


final class DetailInteractor: DetailInteractorProtocol {
    // MARK: Attributes
    public weak var delegate: DetailInteractorDelegate?
    private var details: MealDetails?
  
    func load(id: String) async {
        delegate?.handleOutput(.loadingIndicator(.start))
        let response = await NetworkManager.shared.makeRequest(endpoint: .mealDetails(id: id), method: .get, type: Meals.self)
        delegate?.handleOutput(.loadingIndicator(.stop))
        switch response {
        case .success(let success):
            self.details = success.meals.first
            if let details = details {
                delegate?.handleOutput(.showMeal(details))
            }
        case .failure(let failure):
            delegate?.handleOutput(.showError(failure))
        }
    }
    
    func navigateToVideo() {
        if let details = details {
            delegate?.handleOutput(.setVideo(details.youtubeUrl))
        }
    }
}
