//
//  SearchListTableViewCell.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

class SearchListTableViewCell: BaseTableViewCell {
    static let identifer = "SearchListTableViewCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        return view
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
    }
    
    override func setup() {
        super.setup()
        backgroundColor = .backgroundColor
        selectionStyle = .none
    }
    
    override func setupViews() {
        super.setupViews()
        
        let views = [
            avatarImageView,
            ownerLabel,
            titleLabel,
            descriptionLabel,
            starImageView,
            starCountLabel,
            circleView,
            languageLabel
        ]
        
        contentView.addSubViews(views)
        
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(14)
            make.size.equalTo(14)
        }
        
        ownerLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(4)
            make.top.equalTo(avatarImageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(6)
            make.leading.equalTo(avatarImageView)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView)
            make.trailing.equalToSuperview().inset(8)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.leading.equalTo(avatarImageView)
            make.size.equalTo(14)
            make.bottom.equalToSuperview().inset(14)
        }
        
        starCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
            make.centerY.equalTo(starImageView)
        }
        
        circleView.snp.makeConstraints { make in
            make.leading.equalTo(starCountLabel.snp.trailing).offset(8)
            make.size.equalTo(8)
            make.centerY.equalTo(starImageView)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleView.snp.trailing).offset(4)
            make.centerY.equalTo(starImageView)
        }
    }
    
    func configure(model: SearchDTO) {
        ownerLabel.text = model.owner.login
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        starCountLabel.text = model.starCount.toDecimal
        languageLabel.text = model.language
        avatarImageView.setImage(from: model.owner.avatarURL)
        circleView.backgroundColor = UIColor(named: model.languageColorName)
    }
}
