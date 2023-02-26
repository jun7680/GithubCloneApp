//
//  IntExtension.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/23.
//

import Foundation

extension Int {
    var toDecimal: String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        guard let decimalNumber = format.string(for: self)
        else { return "0" }
        return decimalNumber
    }
}
