//
//  SearchParameters.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation

struct SearchParameters {
    /// 검색어
    let term: String
    /// 필터
    let sort: SortType
    /// 정렬
    let order: OrderType
    /// item count
    let limit: Int
    /// 페이지 == offset
    let page: Int
}
