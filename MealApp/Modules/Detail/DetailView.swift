//
//  DetailView.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
}

final class DetailViewController: UIViewController, DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    private var movieID: String
    
    public init(_ movieID: String) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension DetailViewController {
    override func viewDidLoad()  {
        super.viewDidLoad()
        setupUI()
//        presenter?.load()
    }
}

// MARK: - Setup UI
extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .black
    }
}
