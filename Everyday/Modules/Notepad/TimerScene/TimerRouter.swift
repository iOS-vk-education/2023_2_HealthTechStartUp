//
//  TimerRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import UIKit

final class TimerRouter {
    weak var viewController: TimerViewController?
}

extension TimerRouter: TimerRouterInput {
    func closeTimer() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.dismiss(animated: true)
    }
}
