//
//  Localization.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation

enum Localize {
    enum URL {
        static let baseURL = "https://api.github.com"
        static let searchPath = "/search/repositories"
    }
    enum APIKey {
        static let term = "q"
        static let sort = "sort"
        static let order = "order"
        static let perPage = "per_page"
        static let page = "page"
    }
}
