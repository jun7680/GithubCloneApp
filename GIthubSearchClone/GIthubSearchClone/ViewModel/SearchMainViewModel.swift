//
//  MainViewModel.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation
import RxSwift
import RxRelay
import RealmSwift

protocol SearchMainViewModelInput {
    func search(term: String)
    func fetchAutoComplete(term: String)
    func fetchRecentTermList()
    func deleteTerm(term: String)
    func clearButtonClicked()
    var searchParamsRelay: PublishRelay<SearchParameters> { get }
    var recentTermListRelay: PublishRelay<[RecentWordData]> { get }
}

protocol SearchMainViewModelOutput {
    var searchParamsObservable: Observable<SearchParameters> { get }
    var recentTermListObservable: Observable<[RecentWordData]> { get }
}

class SearchMainViewModel: SearchMainViewModelInput,
                           SearchMainViewModelOutput {
    
    private let disposeBag = DisposeBag()
    private let dao = RecentWordDAO()
    
    var inputs: SearchMainViewModelInput { return self }
    var outputs: SearchMainViewModelOutput { return self }
    
    // List relay property
    var searchParamsRelay = PublishRelay<SearchParameters>()
    var searchParamsObservable: Observable<SearchParameters> {
        return searchParamsRelay.asObservable()
    }
    
    // Recent Term relay property
    var recentTermListRelay = PublishRelay<[RecentWordData]>()
    var recentTermListObservable: Observable<[RecentWordData]> {
        return recentTermListRelay.asObservable()
    }
    
    func search(term: String) {
        let searchParam = SearchParameters(
            term: term,
            sort: .default,
            order: .desc,
            limit: 20,
            page: 1
        )
        searchParamsRelay.accept(searchParam)
        dao.insert(data: RecentWordData(word: term))
        fetchAutoComplete(term: term)
    }
    
    func fetchRecentTermList() {
        let wordList = dao.readToArray()
        recentTermListRelay.accept(wordList)
    }
    
    func deleteTerm(term: String) {
        dao.delete(by: term)
        fetchAutoComplete(term: term)
    }
    
    func clearButtonClicked() {
        dao.deleteAll()
        recentTermListRelay.accept([])
    }
    
    func fetchAutoComplete(term: String) {
        let items: [RecentWordData]
        if term.isEmpty {
            items = dao.readToArray()
        } else {
            items = dao.read(term)
        }
        recentTermListRelay.accept(items)
    }
}
