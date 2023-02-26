//
//  BaseView.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/25.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        initConstraints()
        subscribeUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
    func initConstraints() {}
    func subscribeUI() {}
}
