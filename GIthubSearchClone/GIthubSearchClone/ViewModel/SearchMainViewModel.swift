//
//  MainViewModel.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchMainViewModelInput {
    func search(term: String, sort: SortType, order: OrderType)
    
    var searchParamsRelay: PublishRelay<SearchParameters> { get }
}

protocol SearchMainViewModelOutput {
    var searchParamsObservable: Observable<SearchParameters> { get }
}

class SearchMainViewModel: SearchMainViewModelInput,
                           SearchMainViewModelOutput {
    
    private let disposeBag = DisposeBag()
    
    var inputs: SearchMainViewModelInput { return self }
    var outputs: SearchMainViewModelOutput { return self }
    
    // List relay property
    var searchParamsRelay = PublishRelay<SearchParameters>()
    var searchParamsObservable: Observable<SearchParameters> {
        return searchParamsRelay.asObservable()
    }
    
    func search(term: String, sort: SortType, order: OrderType) {
        let searchParam = SearchParameters(
            term: term,
            sort: sort,
            order: order,
            limit: 20,
            page: 1
        )
        searchParamsRelay.accept(searchParam)
    }
}
