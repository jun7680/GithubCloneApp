//
//  UIViewControllerExtension.swift
//  GIthubSearchClone
//
//  Created by 옥인준 on 2023/02/24.
//

import UIKit
import RxSwift

enum ActionType: String {
    case sort
    case order
    
    var title: String {
        switch self {
        case .sort: return "Sort"
        case .order: return "Order"
        }
    }
}

extension UIViewController {
    func presentOptionAlert(title: String) -> Observable<ActionType> {
        
        return Observable.create { [weak self] observer in
            let controller = UIAlertController(
                title: title,
                message: nil,
                preferredStyle: .actionSheet
            )
            
            let sortAction = UIAlertAction(
                title: ActionType.sort.title,
                style: .default
            ) { _ in
                observer.onNext(.sort)
                observer.onCompleted()
            }
            let orderAction = UIAlertAction(
                title: ActionType.order.title,
                style: .default
            ) { _ in
                observer.onNext(.order)
                observer.onCompleted()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            controller.addAction(sortAction)
            controller.addAction(orderAction)
            controller.addAction(cancelAction)
            
            controller.overrideUserInterfaceStyle = .dark
            
            self?.present(controller, animated: true)
            
            return Disposables.create {
                controller.dismiss(animated: true)
            }
        }
    }
}
