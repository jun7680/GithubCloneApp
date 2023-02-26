//
//  BaseTableViewCell.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupViews()
        initConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {}
    func setupViews() {}
    func initConstraints() {}
}
