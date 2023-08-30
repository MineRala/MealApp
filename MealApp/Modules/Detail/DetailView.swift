//
//  DetailView.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    
    func handleOutput(_ output: DetailPresenterOutput)
}

final class DetailViewController: UIViewController {
    // MARK: Properties
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = Color.white
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()

    private lazy var instrTextView: UITextView = {
        let textView = UITextView()
        textView.tintColor = .white
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 16, weight: .bold)
        textView.autocapitalizationType = .none
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        return textView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .left
        view.addSubview(label)
        return label
    }()
    
    private lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .left
        view.addSubview(label)
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Watch Video", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        view.addSubview(button)
        return button
    }()
    
    // MARK: Attributes
    var presenter: DetailPresenterProtocol?
    private var meal: MealDetails?
}

// MARK: - Lifecycle
extension DetailViewController {
    override func viewDidLoad()  {
        super.viewDidLoad()
        setupUI()
        presenter?.load()
    }
}

// MARK: - Setup UI
extension DetailViewController {
    private func setNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        setNavigationBar()
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-8)
            make.right.equalTo(posterImageView.snp.right).offset(-8)
            make.height.equalTo(56)
            make.width.equalTo(110)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(12)
            make.leading.equalTo(posterImageView.snp.leading).offset(12)
            make.height.equalTo(32)
        }
        
        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.leading.equalTo(categoryLabel)
            make.height.equalTo(32)
        }
        
        instrTextView.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}

// MARK: - Set Data
extension DetailViewController {
    private func setDetails() {
        if let meal = meal {
            posterImageView.kf.setImage(with: URL(string: meal.image))
            titleLabel.text = meal.title
            instrTextView.text = meal.instructions
            categoryLabel.text = meal.category
            areaLabel.text = meal.area
        }
    }
}

// MARK: - Actions
extension DetailViewController {
    @objc func actionButtonTapped() {
        presenter?.navigateToVideo()
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func handleOutput(_ output: DetailPresenterOutput) {
        switch output {
        case .showMeal(let mealDetails):
            self.meal = mealDetails
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.setDetails()
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
