//
//  DetailPresenter.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    
}

final class DetailPresenter: DetailPresenterProtocol {
    private let view: DetailViewProtocol
    private let interactor: DetailInteractorProtocol
    private let router: DetailRouterProtocol
    
    init(view: DetailViewProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
