//
//  ViewController.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol SearchMainViewControllerDelegate: AnyObject {
    func moveSearchList(with params: SearchParameters)
}

class SearchMainViewController: BaseViewController {
    
    private let viewModel: SearchMainViewModel
    private let disposeBag = DisposeBag()
    
    weak var delegate: SearchMainViewControllerDelegate?
    
    private let searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search Repository"
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.autocorrectionType = .no
        
        return controller
    }()
    
    private let headerView = RecentHeaderView()
    
    private lazy var recentSearchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.isHidden = true
        tableView.register(
            RecentWordTableViewCell.self,
            forCellReuseIdentifier: RecentWordTableViewCell.identifier
        )
        tableView.rowHeight = 44
        tableView.keyboardDismissMode = .onDrag
        tableView.tableHeaderView = headerView
        tableView.isHidden = true
        return tableView
    }()
    
    init(viewModel: SearchMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setup() {
        super.setup()
        navigationItem.searchController = searchController
        headerView.clearAction = { [weak self] in
            self?.viewModel.inputs.clearButtonClicked()
        }
    }
    
    override func setupWillAppear() {
        super.setupWillAppear()
        setupNavigationItems()
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(recentSearchTableView)
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        recentSearchTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(recentSearchTableView)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        
        bindSearchParamsEvents()
        bindRecentSearchesEvents()
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        
        recentTermSelected()
        searchBarEvents()
    }
}

// MARK: - Private function
extension SearchMainViewController {
    
    /// navigation setting
    private func setupNavigationItems() {
        // SearchBar TextColor 변경
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    /// 검색 파라미터 events
    private func bindSearchParamsEvents() {
        viewModel.outputs.searchParamsObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, params in
                owner.delegate?.moveSearchList(with: params)
            }.disposed(by: disposeBag)
    }
    
    /// 최근검색어 관련 events
    private func bindRecentSearchesEvents() {
        viewModel.outputs.recentTermListObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: recentSearchTableView.rx.items(
                cellIdentifier: RecentWordTableViewCell.identifier,
                cellType: RecentWordTableViewCell.self)
            ) { [weak self] index, term, cell in
                cell.configure(term: term.term) {
                    self?.viewModel.inputs.deleteTerm(term: term.term)
                }
            }.disposed(by: disposeBag)
        
        // 자동완선 테이블뷰 hidden 조건
        viewModel.outputs.recentTermListObservable
            .bind(with: self) { owner, items in
                owner.recentTableViewHidden(by: items)
            }.disposed(by: disposeBag)
    }
    
    /// 최근검색어 선택 Events
    private func recentTermSelected() {
        recentSearchTableView.rx
            .modelSelected(RecentWordData.self)
            .subscribe(with: self) { owner, model in
                owner.searchController.searchBar.text = model.term
                owner.viewModel.inputs.search(term: model.term)
            }.disposed(by: disposeBag)
    }
    
    /// 최근검색어 테이블뷰 숨김 조건
    /// - Parameter items: [RecentWordData]
    private func recentTableViewHidden(by items: [RecentWordData]) {
        self.recentSearchTableView.isHidden = items.isEmpty
    }
    
    /// searchbar 관련 이벤트
    private func searchBarEvents() {
        // 서치버튼 이벤트
        searchController.searchBar.rx.searchButtonClicked
            .bind(with: self) { owner, _ in
                let term = owner.searchController.searchBar.text ?? ""
                owner.viewModel.inputs.search(term: term)
            }.disposed(by: disposeBag)
        
        // 검색어 입력 시작 이벤트
        searchController.searchBar.rx.textDidBeginEditing
            .bind(with: self) { owner, _ in
                UIView.transition(
                    with: owner.recentSearchTableView,
                    duration: 1,
                    options: .transitionCrossDissolve,
                    animations: {
                        owner.autoCompleteBind()
                        owner.viewModel.inputs.fetchRecentTermList()
                    })
            }.disposed(by: disposeBag)
        
        // searchbar 취소버튼 이벤트
        searchController.searchBar.rx.cancelButtonClicked
            .bind(with: self) { owner, _ in
                owner.recentSearchTableView.isHidden = true
            }.disposed(by: disposeBag)
    }
    
    /// 검색어 텍스트 바인딩
    private func autoCompleteBind() {
        searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(400), scheduler: MainScheduler.asyncInstance)
            .bind(with: self) { owner, text in
                owner.viewModel.inputs.fetchAutoComplete(term: text)
            }.disposed(by: disposeBag)
    }
}
