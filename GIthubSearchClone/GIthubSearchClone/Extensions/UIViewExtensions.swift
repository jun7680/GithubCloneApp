//
//  UIViewExtensions.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import UIKit

extension UIView {
    /// Add Subview
    /// - Parameter views: [UIView]
    func addSubViews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
    
}

extension UIStackView {
    /// ArrangeSubView for UIStackView
    /// - Parameter child: [UIView]
    func addArrangeSubViews(_ child: [UIView]) {
        child.forEach {
            addArrangedSubview($0)
        }
    }
}
