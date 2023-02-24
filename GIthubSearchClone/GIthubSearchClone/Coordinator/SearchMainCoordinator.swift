//
//  SearchMainCoordinator.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

protocol SearchMainCoordinatorDelegate {
    func moveSearchList(with params: SearchParameters,
                        coordinator: SearchMainCoordinator)
}

class SearchMainCoordinator: Coordinator,
                             SearchMainViewControllerDelegate {
    
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    var delegate: SearchMainCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSearchMain()
    }
    
    func moveSearchList(with params: SearchParameters) {
        delegate?.moveSearchList(with: params, coordinator: self)
    }
}

// MARK: - private function
extension SearchMainCoordinator {
    private func showSearchMain() {
        let viewController = SearchMainViewController(
            viewModel: SearchMainViewModel()
        )
        viewController.delegate = self
        viewController.title = "GitHub"
//        navigationController.navigationBar.prefersLargeTitles = true
//        let titleAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white
//        ]
//        navigationController.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController.viewControllers = [viewController]
    }
}
