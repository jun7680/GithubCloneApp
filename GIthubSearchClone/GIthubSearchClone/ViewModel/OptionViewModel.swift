//
//  OptionViewModel.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/24.
//

import Foundation
import RxRelay
import RxSwift

protocol OptionViewModelInput {
    func fetchList(type: ActionType)
    var optionList: BehaviorRelay<[OptionTypeProtocol]> { get }
}

protocol OptionViewModelOutput {
    var optionListObservable: Observable<[OptionTypeProtocol]> { get }
}

class OptionViewModel: OptionViewModelInput, OptionViewModelOutput {

    var inputs: OptionViewModelInput { return self }
    var outputs: OptionViewModelOutput { return self }
    
    var optionList = BehaviorRelay<[OptionTypeProtocol]>(value: [])
    var optionListObservable: Observable<[OptionTypeProtocol]> {
        return optionList.asObservable()
    }
    
    func fetchList(type: ActionType) {
        let optionList: [OptionTypeProtocol]
        switch type {
        case .sort:
            optionList = SortType.allCases
        case .order:
            optionList = OrderType.allCases
        }
        
        self.optionList.accept(optionList)
    }
}
