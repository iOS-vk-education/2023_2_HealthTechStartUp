//
//  ChangeLanguageRouter.swift
//  Everyday
//
//  Created by Yaz on 05.05.2024.
//
//

import UIKit

final class ChangeLanguageRouter {
    weak var viewController: ChangeLanguageViewController?
}

extension ChangeLanguageRouter: ChangeLanguageRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
