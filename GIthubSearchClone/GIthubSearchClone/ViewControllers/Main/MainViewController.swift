//
//  ViewController.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search Repository"
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub"
        navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
    }
}

