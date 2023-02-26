//
//  RecentWordDAO.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/25.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

struct RecentWordDAO {
    
    func read() -> Results<RecentWordData> {
        return RealmManager.read(RecentWordData.self)
    }
    
    func readToArray() -> [RecentWordData] {
        return read().toArray().sorted { $0.time > $1.time }
    }
    
    func read(_ term: String) -> [RecentWordData] {
        return read().filter { $0.term.contains(term) }
            .sorted { $0.term > $1.term }
    }
    
    func readToDelete(by term: String) -> [RecentWordData] {
        return read().filter { $0.term == term }
            .sorted { $0.term > $1.term }
    }
    
    func insert(data: RecentWordData) {
        RealmManager.add(data)
    }
    
    func delete(by term: String) {
        readToDelete(by: term).forEach {
            RealmManager.delete($0)
        }
    }
    
    func deleteAll() {
        read().forEach {
            RealmManager.delete($0)
        }
    }
}
