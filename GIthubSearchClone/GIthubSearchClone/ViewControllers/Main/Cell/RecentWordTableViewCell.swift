//
//  RecentWordTableViewCell.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class RecentWordTableViewCell: BaseTableViewCell {
    static let identifier = "RecentWordTableViewCell"
    
    private var disposeBag = DisposeBag()
    
    private let termLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var deleteAction: (() -> Void)?

    override func setup() {
        super.setup()
        
        selectionStyle = .none
        backgroundColor = .tableViewBackground
        
        subscribeUI()
    }
    
    override func setupViews() {
        super.setupViews()
        
        let views = [
            termLabel,
            deleteButton
        ]
        
        contentView.addSubViews(views)
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        termLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(deleteButton.snp.leading)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalTo(termLabel)
        }
    }
    
    func configure(term: String, deleteAction: @escaping (() -> Void)) {
        termLabel.text = term
        self.deleteAction = deleteAction
    }
    
    private func subscribeUI() {
        
        deleteButton.rx.tap
            .bind(with: self) { owner, _ in
                guard let action = owner.deleteAction else { return }
                action()
            }.disposed(by: disposeBag)
    }
}
