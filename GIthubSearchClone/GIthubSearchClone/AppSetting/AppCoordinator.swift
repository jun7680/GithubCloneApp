//
//  AppCoordinator.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showMainViewController()
    }
    
    private func showMainViewController() {
        let viewController = SearchMainViewController()
        viewController.view.backgroundColor = .black
        navigationController.viewControllers = [viewController]
    }
}
