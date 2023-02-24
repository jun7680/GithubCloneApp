//
//  SearchListCoordinator.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

class SearchListCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var params: SearchParameters
    
    init(navigationController: UINavigationController, params: SearchParameters) {
        self.navigationController = navigationController
        self.params = params
    }
    
    func start() {
        showSearchList()
    }
}

// MARK: - private function
extension SearchListCoordinator {
    private func showSearchList() {
        let viewController = SearchListViewController(
            viewModel: SearchListViewModel(with: params)
        )
        viewController.title = "Repositories"
        setNavigation(viewController)
    }
    
    private func setNavigation(_ viewController: UIViewController) {
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
