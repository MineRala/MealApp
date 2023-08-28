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

final class DetailViewController: UIViewController, DetailViewProtocol {
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.backgroundColor = .orange
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        view.addSubview(stackView)
        return stackView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .blue
        label.textAlignment = .left
        return label
    }()
    
    private lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .blue
        label.textAlignment = .left
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Watch Video", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        view.addSubview(button)
        return button
    }()
    
    var presenter: DetailPresenterProtocol?
    private var meal: MealDetails?
    
    func handleOutput(_ output: DetailPresenterOutput) {
        switch output {
        case .showMeal(let mealDetails):
            self.meal = mealDetails
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.setDetails()
            }
        case .showError(let error):
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.showToast(title: "Error", text: error.rawValue, delay: 5)
            }
        }
    }
    
    @objc func actionButtonTapped() {
        presenter?.navigateToVideo()
    }
}

// MARK: - Lifecycle
extension DetailViewController {
    override func viewDidLoad()  {
        super.viewDidLoad()
        setupUI()
        presenter?.load()
    }
    
    private func setNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - Setup UI
extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .black
        setNavigationBar()
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-4)
            make.right.equalTo(posterImageView.snp.right).offset(-4)
            make.height.equalTo(60)
            make.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(80)
        }
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(areaLabel)
        
        instrTextView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
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
