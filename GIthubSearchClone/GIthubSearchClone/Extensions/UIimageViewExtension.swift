//
//  UIimageViewExtension.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/24.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        ImageCache.shared.requestImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
