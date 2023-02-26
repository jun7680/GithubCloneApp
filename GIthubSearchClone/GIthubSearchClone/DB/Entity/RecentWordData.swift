//
//  RecentWordData.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/25.
//

import Foundation
import RealmSwift

class RecentWordData: Object {
    @Persisted(primaryKey: true) var term: String
    @Persisted var time: Double
    
    override init() {}
    
    init(word: String) {
        super.init()
        self.term = word
        self.time = Date().timeIntervalSince1970
    }
}
