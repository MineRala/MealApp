//
//  DetailRouter.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import Foundation

protocol DetailRouterProtocol: AnyObject {
    func navigateToVideo(videoUrl: String, on view: DetailViewProtocol)
}

final class DetailRouter: DetailRouterProtocol {
    static func build(mealID: String) -> DetailViewProtocol {
        let view: DetailViewProtocol = DetailViewController()
        let interactor: DetailInteractorProtocol = DetailInteractor()
        let router: DetailRouterProtocol = DetailRouter()
        let presenter: DetailPresenterProtocol = DetailPresenter(view: view, interactor: interactor, router: router, mealID: mealID)
        view.presenter = presenter
        return view
    }
    
    func navigateToVideo(videoUrl: String, on view: DetailViewProtocol) {
        guard let viewController = view as? DetailViewController else { return }
        guard let videoViewController = VideoRouter.build(url: videoUrl) as? VideoViewController else { return }
        viewController.navigationController?.pushViewController(videoViewController, animated: true)
    }
}
