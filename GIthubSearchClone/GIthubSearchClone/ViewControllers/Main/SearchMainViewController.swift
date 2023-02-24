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
        return controller
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
    }
    
    override func setupWillAppear() {
        super.setupWillAppear()
        setupNavigationItems()
    }
    
    override func setupViews() {
        super.setupViews()
    }
    
    override func bind() {
        super.bind()
        
        viewModel.outputs.searchParamsObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, params in
                owner.delegate?.moveSearchList(with: params)
            }.disposed(by: disposeBag)
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        
        searchController.searchBar.rx.searchButtonClicked
            .bind(with: self) { owner, _ in
                let term = owner.searchController.searchBar.text ?? ""
                owner.viewModel.inputs.search(
                    term: term,
                    sort: .default,
                    order: .desc
                )
            }.disposed(by: disposeBag)
    }
}

// MARK: - Private function
extension SearchMainViewController {
    
    private func setupNavigationItems() {
        // SearchBar TextColor 변경
        searchController.searchBar.searchTextField.textColor = .white
    }
}

