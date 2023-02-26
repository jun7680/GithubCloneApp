//
//  BaseViewController.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

class BaseViewController: UIViewController {
    private let alert: UIAlertController = {
        let alert = UIAlertController(
            title: nil,
            message: Localize.View.errorMSG,
            preferredStyle: .alert
        )
        
        let defaultAction = UIAlertAction(title: Localize.View.confirm, style: .default)
        alert.addAction(defaultAction)
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        initConstraints()
        bind()
        subscribeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupWillAppear()
    }
    
    func setup() {}
    func setupViews() {}
    func setupWillAppear() {}
    func bind() {}
    func subscribeUI() {}
    func initConstraints() {}
    
    func errorPresent() {
        present(alert, animated: true)
    }
}
