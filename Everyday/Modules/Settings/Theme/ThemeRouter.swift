//
//  ThemeRouter.swift
//  Everyday
//
//  Created by Yaz on 08.03.2024.
//
//

import UIKit

final class ThemeRouter {
    weak var viewController: ThemeViewController?
}

extension ThemeRouter: ThemeRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
