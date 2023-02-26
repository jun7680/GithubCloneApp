//
//  SearchListViewController.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit
import RxSwift
import RxCocoa


class SearchListViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: SearchListViewModel
    
    private let searchListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.register(
            SearchListTableViewCell.self,
            forCellReuseIdentifier: SearchListTableViewCell.identifer
        )
        return tableView
    }()
    
    private let optionButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle")
        )
        
        return barButton
    }()
    
    init(viewModel: SearchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        ActivityIndicator.showLoading()
        navigationItem.rightBarButtonItem = optionButton
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(searchListTableView)
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        searchListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        
        bindSearchListEvents()
        bindLoadingEvents()
        bindErrorEvents()
        
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        willDisplayCellEvents()
        
        optionButton.rx.tap
            .flatMap { _ in
                return self.presentOptionAlert(title: "Sort options")
            }.subscribe(with: self) { owner, type in
                let vc = OptionViewController(type: type)
                vc.delegate = owner
                owner.present(vc, animated: true)
            }.disposed(by: disposeBag)
    }
}

// MARK: - private function
extension SearchListViewController {
    /// willDisplayCell events
    private func willDisplayCellEvents() {
        searchListTableView.rx.willDisplayCell
            .subscribe(with: self) { owner, cell in
                owner.viewModel.inputs.fetchMore(
                    row: cell.indexPath.row
                )
            }.disposed(by: disposeBag)
    }
    
    /// 검색결과 바인딩
    private func bindSearchListEvents() {
        viewModel.outputs.searchListObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: searchListTableView.rx.items(
                cellIdentifier: SearchListTableViewCell.identifer,
                cellType: SearchListTableViewCell.self
            )) { index, item, cell in
                cell.configure(model: item)
            }.disposed(by: disposeBag)
        
    }
    
    /// 로딩 이벤트 바인딩
    private func bindLoadingEvents() {
        viewModel.outputs.loadingFinishObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, status in
                switch status {
                case true: ActivityIndicator.hideLoading()
                case false: ActivityIndicator.showLoading()
                }
            }.disposed(by: disposeBag)
    }
    
    /// 에러 이벤트 바인딩
    private func bindErrorEvents() {
        viewModel.outputs.errorObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, _ in
                owner.errorPresent()
            }.disposed(by: disposeBag)
    }
}

extension SearchListViewController: OptionSelectDelegate {
    func optionSelected(with option: OptionTypeProtocol) {
        viewModel.inputs.optionSelect(option: option)
    }
}
