//
//  APIType.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation

protocol APIType {
    var baseURL: URL { get }
    var path: String { get }
    var params: [String: Any] { get }
}
