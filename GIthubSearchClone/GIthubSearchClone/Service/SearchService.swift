//
//  SearchService.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation
import RxSwift

protocol SearchServiceRequest {
    static func fetch(params: SearchParameters) -> Single<SearchResponse>
}

class SearchService: SearchServiceRequest {
    static func fetch(params: SearchParameters) -> Single<SearchResponse> {
        let type = SearchAPI.fetch(params: params)
        return SessionManager.shared.request(type: type)
    }
}
