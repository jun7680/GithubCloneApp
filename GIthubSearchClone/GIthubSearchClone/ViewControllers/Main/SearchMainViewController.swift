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

class SearchMainViewController: BaseViewController {
    
    private let viewModel = SearchMainViewModel()
    private let disposeBag = DisposeBag()
    
    private let searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search Repository"
        return controller
    }()
    
    override func setup() {
        super.setup()
        title = "GitHub"
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
        navigationController?.navigationBar.prefersLargeTitles = true
        let titleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        // SearchBar TextColor 변경
        searchController.searchBar.searchTextField.textColor = .white
    }
}

