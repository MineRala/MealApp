//
//  HomeView.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import UIKit
import SnapKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func handleOutput(_ output: HomePresenterOutput)
}

final class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    private var meals: [Meal] = []
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .vertical
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black.withAlphaComponent(0.8)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        return collectionView
    }()
    
    func handleOutput(_ output: HomePresenterOutput) {
        switch output {
        case .showMealList(let list):
            meals = list
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.collectionView.reloadData()
            }
        case .loadingIndicator(let indicatorMode):
            switch indicatorMode {
            case .start:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.showLoadingView()
                }
            case .stop:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.dismissLoadingView()
                }
            }
        case .showError(let error):
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.showToast(title: "Error", text: error.rawValue, delay: 5)
            }            
        }
    }
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad()  {
        super.viewDidLoad()
        setupUI()
        presenter?.load()
    }
}
// MARK: - UI
extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .black.withAlphaComponent(0.8)
        configureNavigationController()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = .black.withAlphaComponent(0.8)
        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Meals"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}

// MARK: CollectionView Protocols
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            let meal = meals[indexPath.row]
            cell.setCell(model: meal)
            return cell}
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter?.selectMeal(index: indexPath.row)
    }
}
