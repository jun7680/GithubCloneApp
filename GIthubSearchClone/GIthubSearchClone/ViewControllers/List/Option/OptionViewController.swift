//
//  OptionViewController.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/24.
//

import UIKit
import RxCocoa
import RxSwift

protocol OptionSelectDelegate: AnyObject {
    func optionSelected(with option: OptionTypeProtocol)
}

class OptionViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = OptionViewModel()
    private let type: ActionType
    
    weak var delegate: OptionSelectDelegate?
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .tableViewBackground
        return view
    }()
    
    private let titleSeperatorView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localize.View.cancel, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    private let optionTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .tableViewBackground
        tableView.register(
            OptionTableViewCell.self,
            forCellReuseIdentifier: OptionTableViewCell.identifier
        )
        tableView.rowHeight = 56
        
        return tableView
    }()
    
    init(type: ActionType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        
        view.backgroundColor = .tableViewBackground
        titleLabel.text = type.title
        fetchOptionList(type: type)
    }
    
    override func setupViews() {
        super.setupViews()
        let titleViews = [
            cancelButton,
            titleLabel,
            titleSeperatorView
        ]
        titleView.addSubViews(titleViews)
        
        let views = [
            titleView,
            optionTableView
        ]
        view.addSubViews(views)
    }
    
    override func initConstraints() {
        super.initConstraints()
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        titleSeperatorView.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
            titleSeperatorView.backgroundColor = optionTableView.separatorColor
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.center.equalToSuperview()
        }
        
        optionTableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        bindOptionListEvents()
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        
        cancelButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
        
        optionTableView.rx
            .modelSelected(OptionTypeProtocol.self)
            .bind(with: self) { owner, type in
                owner.dismiss(animated: true) {
                    owner.delegate?.optionSelected(with: type)
                }
            }.disposed(by: disposeBag)
    }
}

// MARK: - private function
extension OptionViewController {
    private func bindOptionListEvents() {
        viewModel.outputs.optionListObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: optionTableView.rx.items(
                cellIdentifier: OptionTableViewCell.identifier,
                cellType: OptionTableViewCell.self
            )) { _, option, cell in
                cell.configure(option: option)
            }.disposed(by: disposeBag)
    }
    
    private func fetchOptionList(type: ActionType) {
        viewModel.inputs.fetchList(type: type)
    }
}
