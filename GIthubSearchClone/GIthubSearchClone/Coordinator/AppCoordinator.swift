//
//  AppCoordinator.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator, SearchMainCoordinatorDelegate {
    
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainViewController()
    }
    
    func moveSearchList(
        with params: SearchParameters,
        coordinator: SearchMainCoordinator
    ) {
        pushListViewController(with: params)
    }
    
}

// MARK: - Private function
extension AppCoordinator {
    /// show MainViewController
    private func showMainViewController() {
        let coordinator = SearchMainCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinator.append(coordinator)
    }
    
    /// push ListViewController
    private func pushListViewController(with params: SearchParameters) {
        let coordinator = SearchListCoordinator(
            navigationController: navigationController,
            params: params
        )
        coordinator.start()
        childCoordinator.append(coordinator)
    }
}
