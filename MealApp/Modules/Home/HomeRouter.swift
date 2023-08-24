//
//  HomeRouter.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    
}

final class HomeRouter: HomeRouterProtocol {
     static func start() -> HomeViewProtocol {
         let view: HomeViewProtocol = HomeViewController()
         let interactor: HomeInteractorProtocol = HomeInteractor()
         let router: HomeRouterProtocol = HomeRouter()
         let presenter: HomePresenterProtocol = HomePresenter(view: view, interactor: interactor, router: router)
         view.presenter = presenter
         return view
     }
}
