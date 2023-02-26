//
//  SearchViewModel.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchListViewModelInput {
    func fetch()
    func fetchMore(row: Int)
    func optionSelect(option: OptionTypeProtocol)
    
    var searchListRelay: PublishRelay<[SearchDTO]> { get }
    var loadingFinishRelay: PublishRelay<Bool> { get }
}

protocol SearchListViewModelOutput {
    var searchListObservable: Observable<[SearchDTO]> { get }
    var loadingFinishObservable: Observable<Bool> { get }
}

class SearchListViewModel: SearchListViewModelInput,
                           SearchListViewModelOutput {
    
    var inputs: SearchListViewModelInput { return self }
    var outputs: SearchListViewModelOutput { return self }
    
    private let disposeBag = DisposeBag()
    private var params: SearchParameters
    private var searchListItems = [SearchDTO]()
    
    var searchListRelay = PublishRelay<[SearchDTO]>()
    var searchListObservable: Observable<[SearchDTO]> {
        return searchListRelay.asObservable()
    }
    
    var loadingFinishRelay = PublishRelay<Bool>()
    var loadingFinishObservable: Observable<Bool> {
        return loadingFinishRelay.asObservable()
    }
    
    // MARK: - pagination property
    private var isMoreItems = true
    private var isRequesting = false
    
    // MARK: - init
    init(with params: SearchParameters) {
        self.params = params
        fetch()
    }
    
    func fetch() {
        // 중복 호출 방지
        guard !isRequesting, isMoreItems else { return }
        loadingFinishRelay.accept(false)
        isRequesting = true
        
        SearchService.fetch(params: params)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(with: self, onSuccess: { owner, result in
                if result.items.count < owner.params.limit {
                    owner.isMoreItems = false
                } else {
                    owner.isMoreItems = true
                    owner.params.page += 1
                }
                owner.searchListItems.append(contentsOf: result.items)
                owner.searchListRelay.accept(owner.searchListItems)
                owner.isRequesting = false
                owner.loadingFinishRelay.accept(true)
            }, onFailure: { owner, error in
                owner.loadingFinishRelay.accept(true)
            }).disposed(by: disposeBag)
    }
    
    func fetchMore(row: Int) {
        if row >= searchListItems.count - 3 {
            fetch()
        }
    }
    
    func optionSelect(option: OptionTypeProtocol) {
        refreshItems()
        if let option = option as? SortType {
            params.sort = option
        } else if let option = option as? OrderType {
            params.order = option
        }
        fetch()
    }
    
    func refreshItems() {
        searchListItems.removeAll()
        isRequesting = false
        isMoreItems = true
        params.page = 1
    }
}
