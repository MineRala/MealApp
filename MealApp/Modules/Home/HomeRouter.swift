//
//  HomeRouter.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    func navigateToDetail(mealID: String, on view: HomeViewProtocol)
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
    
    func navigateToDetail(mealID: String, on view: HomeViewProtocol) {
        guard let viewController = view as? HomeViewController else { return }
        guard let detailViewController = DetailRouter.build(mealID: mealID) as? DetailViewController else { return }
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
