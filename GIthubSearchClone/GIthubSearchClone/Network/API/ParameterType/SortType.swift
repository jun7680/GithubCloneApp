//
//  SortType.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation

protocol OptionTypeProtocol {}

enum SortType: String, CaseIterable, OptionTypeProtocol {
    case `default`
    case stars
    case forks
    case helpWantedIssue = "help-wanted-issues"
    case updated
}
