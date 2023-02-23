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
    
    var searchListRelay: PublishRelay<[SearchDTO]> { get }
}

protocol SearchMainViewModelOutput {
    var searchListObservable: Observable<[SearchDTO]> { get }
}

class SearchMainViewModel: SearchMainViewModelInput,
                           SearchMainViewModelOutput {
    
    private let disposeBag = DisposeBag()
    private var searchListItems = [SearchDTO]()
    
    var inputs: SearchMainViewModelInput { return self }
    var outputs: SearchMainViewModelOutput { return self }
    
    // List relay property
    var searchListRelay = PublishRelay<[SearchDTO]>()
    var searchListObservable: Observable<[SearchDTO]> {
        return searchListRelay.asObservable()
    }
    
    func search(term: String, sort: SortType, order: OrderType) {
        let searchParam = SearchParameters(
            term: term,
            sort: sort,
            order: order,
            limit: 30,
            page: 1
        )
        
        SearchService.fetch(params: searchParam)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(with: self) { owner, result in
                print(result)
                owner.searchListItems.append(contentsOf: result.items)
                owner.searchListRelay.accept(owner.searchListItems)
            }.disposed(by: disposeBag)
    }

}
