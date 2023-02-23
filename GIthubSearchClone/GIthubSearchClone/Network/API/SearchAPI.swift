//
//  SearchAPI.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation

enum SearchAPI {
    case fetch(params: SearchParameters)
}

extension SearchAPI: APIType {
    var baseURL: URL {
        guard let url = URL(string: Localize.URL.baseURL)
        else { fatalError("BaseURL is Wrong...") }
        
        return url
    }
    
    var path: String {
        switch self {
        case .fetch: return Localize.URL.searchPath
        }
    }
    
    var params: [String : Any] {
        switch self {
        case let .fetch(params):
            return [
                Localize.APIKey.term: params.term,
                Localize.APIKey.order: params.order,
                Localize.APIKey.perPage: params.limit,
                Localize.APIKey.page: params.page
            ]
            
        }
    }
}
