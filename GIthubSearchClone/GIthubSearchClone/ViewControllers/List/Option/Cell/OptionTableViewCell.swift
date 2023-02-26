//
//  OptionTableViewCell.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/24.
//

import UIKit

class OptionTableViewCell: BaseTableViewCell {
    static let identifier = "OptionTableViewCell"
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    override func setup() {
        super.setup()
        backgroundColor = .tableViewBackground
        selectionStyle = .none
    }
    
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(optionLabel)
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        optionLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    func configure(option: OptionTypeProtocol) {
        if let sortType = option as? SortType {
            optionLabel.text = sortType.rawValue
        }
        
        if let orderType = option as? OrderType {
            optionLabel.text = orderType.rawValue
        }
    }
}
