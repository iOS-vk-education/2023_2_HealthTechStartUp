//
//  DateAndTimeRouter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class DateAndTimeRouter {
    weak var viewController: DateAndTimeViewController?
}

extension DateAndTimeRouter: DateAndTimeRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
