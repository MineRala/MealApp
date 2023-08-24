//
//  HomeCell.swift
//  MealApp
//
//  Created by Mine Rala on 17.08.2023.
//


import UIKit
import SnapKit
import Kingfisher

private enum HomeTableViewCellConstnt {
    static let viewColor = Color.cellBackgrounColor
    static let borderColor = Color.black
}

final class HomeCollectionViewCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = HomeTableViewCellConstnt.viewColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = HomeTableViewCellConstnt.borderColor.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 12
        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Color.black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Color.black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        categoryLabel.text = nil
    }
}

//MARK: - Configure Cell
extension HomeCollectionViewCell {
    private func configureCell() {
        contentView.addSubview(containerView)
    
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview()
        }
        
        containerView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        containerView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.07)
        }
    }
}

//MARK: - Set Cell
extension HomeCollectionViewCell {
    func setCell(model: Meal) {
        posterImageView.kf.setImage(with: URL(string: model.image))
        titleLabel.text = model.title
        categoryLabel.text = model.category
    }
}
