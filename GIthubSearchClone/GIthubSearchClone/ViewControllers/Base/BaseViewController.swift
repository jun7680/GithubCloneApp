//
//  BaseViewController.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        bind()
        subscribeUI()
        initConstraints()
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
}
