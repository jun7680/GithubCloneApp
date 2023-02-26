//
//  RecentHeaderView.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class RecentHeaderView: BaseView {
    
    private let disposeBag = DisposeBag()
    
    var clearAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Recent searches"
        
        return label
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    override func setupView() {
        super.setupView()
        
        let views = [
            titleLabel,
            clearButton
        ]
        
        addSubViews(views)
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(4)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(clearButton.snp.leading)
        }
        
        clearButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(4)
            make.top.bottom.equalToSuperview()
        }
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        
        clearButton.rx.tap
            .bind(with: self) { owner, _ in
                guard let action = owner.clearAction
                else { return }
                
                action()
                
            }.disposed(by: disposeBag)
    }
}
