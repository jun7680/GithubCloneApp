//
//  SearchListViewModelTest.swift
//  GIthubSearchCloneTests
//
//  Created by 옥인준 on 2023/02/26.
//

import XCTest
import RxBlocking

@testable import GIthubSearchClone

final class SearchListViewModelTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func fetchTest() throws {
        let params = SearchParameters(
            term: "swift",
            sort: .default,
            order: .asc,
            limit: 30,
            page: 1
        )
        let dto = try SearchService.fetch(params: params)
            .asObservable()
            .toBlocking(timeout: 10)
            .first()
        
        XCTAssertNotNil(dto)
        
        // 내림차순
        let params2 = SearchParameters(
            term: "swift",
            sort: .default,
            order: .desc,
            limit: 30,
            page: 2
        )
        
        let dto2 = try SearchService.fetch(params: params2)
            .asObservable()
            .toBlocking(timeout: 10)
            .first()
        
        XCTAssertNotNil(dto2)
        
        let params3 = SearchParameters(
            term: "swift",
            sort: .stars,
            order: .desc,
            limit: 30,
            page: 2
        )
        
        let dto3 = try SearchService.fetch(params: params3)
            .asObservable()
            .toBlocking(timeout: 10)
            .first()
        
        XCTAssertNotNil(dto3)
    }

}
