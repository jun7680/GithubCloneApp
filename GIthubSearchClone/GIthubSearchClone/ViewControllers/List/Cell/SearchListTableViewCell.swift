//
//  SearchListTableViewCell.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

class SearchListTableViewCell: BaseTableViewCell {
    static let identifer = "SearchListTableViewCell"
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let topInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        
        return stackView
    }()
    
    private let bottomInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        
        return stackView
    }()
    
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        
        return imageView
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    override func setup() {
        super.setup()
    }
    
    override func setupViews() {
        super.setupViews()
        
        let containerChild = [
            topInfoStackView,
            titleLabel,
            descriptionLabel,
            bottomInfoStackView
        ]
        
        containerStackView.addArrangeSubViews(containerChild)
        
        let topInfoChild = [
            avatarImageView,
            ownerLabel
        ]
        
        topInfoStackView.addArrangeSubViews(topInfoChild)
        
        let bottomInfoChild = [
            starImageView,
            starCountLabel,
            languageLabel
        ]
        
        bottomInfoStackView.addArrangeSubViews(bottomInfoChild)
        contentView.addSubview(containerStackView)
        
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints { make in
            make.size.equalTo(12)
        }
    }
    
    func configure(model: SearchDTO) {
        ownerLabel.text = model.owner.login
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        starCountLabel.text = model.starCount.toDecimal
        languageLabel.text = model.language
        // TODO: - Image 처리 후 avatar 구현
    }
}
