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
    
    enum View {
        static let searchBarPlaceholder = "Search Repository"
        static let confirm = "확인"
        static let cancel = "Cancel"
        static let clear = "Clear"
        static let recentSearches = "Recent searches"
        static let errorMSG = "에상치 못한 에러가 발생하였습니다.\n잠시 후 다시 시도해주세요."
    }
}
