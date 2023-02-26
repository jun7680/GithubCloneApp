//
//  File.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/26.
//

import Foundation

enum LanguageType: String {
    case swift
    case java
    case javaScript
    case c
    case cPlusPlus = "c++"
    case python
    case other
    
    init(language: String?) {
        switch language {
        case "Swift": self = .swift
        case "Java": self = .java
        case "javaScript": self = .javaScript
        case "C": self = .c
        case "C++": self = .cPlusPlus
        case "python": self = .python
        default: self = .other
        }
    }
}
