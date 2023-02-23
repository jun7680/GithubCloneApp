//
//  GIthubSearchCloneTests.swift
//  GIthubSearchCloneTests
//
//  Created by 옥인준 on 2023/02/23.
//

import XCTest
import RxBlocking
@testable import GIthubSearchClone

final class GIthubSearchCloneTests: XCTestCase {
    var searchService: SearchService!
    
    override func setUpWithError() throws {
        searchService = SearchService()
    }

    override func tearDownWithError() throws {
        searchService = nil
    }
    
    func testFetch() throws {
        let params = SearchParameters(
            term: "swift",
            sort: .default,
            order: .asc,
            limit: 30,
            page: 1
        )
        let dto = try searchService.fetch(params: params)
            .asObservable()
            .toBlocking(timeout: 10)
            .first()
        
        XCTAssertNotNil(dto)
    }
}
