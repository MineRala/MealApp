//
//  DetailRouter.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol DetailRouterProtocol: AnyObject {
    
}

final class DetailRouter: DetailRouterProtocol {
    static func build(movieID: String) -> DetailViewProtocol {
        let view: DetailViewProtocol = DetailViewController(movieID)
        let interactor: DetailInteractorProtocol = DetailInteractor()
        let router: DetailRouterProtocol = DetailRouter()
        let presenter: DetailPresenterProtocol = DetailPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
