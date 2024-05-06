//
//  SettingsRouter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import UIKit

final class SettingsRouter {
    weak var viewController: SettingsViewController?
}

extension SettingsRouter: SettingsRouterInput {
    func openURL(_ appUrl: URL, _ webUrl: URL) {
        if UIApplication.shared.canOpenURL(appUrl) {
            UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
        } else {
            if UIApplication.shared.canOpenURL(webUrl) {
                UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
            } else {
                print("alert manager will be placed here after merge new_auth")
            }
        }
    }
    
    func getShareView(with items: [Any]) {
            let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController?.present(activityViewController, animated: true)
    }
    
    func getChangeLanguageView() {
        guard let viewController = viewController else {
            return
        }
        
        let changeLanguagesContainer = ChangeLanguageContainer.assemble(with: .init())
        let changeLanguagesController = changeLanguagesContainer.viewController
        
        changeLanguagesController.hidesBottomBarWhenPushed = false
        viewController.navigationController?.pushViewController(changeLanguagesController, animated: true)
    }
    
    func getThemeView() {
        guard let viewController = viewController else {
            return
        }
        
        let themeContainer = ThemeContainer.assemble(with: .init())
        let themeViewController = themeContainer.viewController
        
        themeViewController.hidesBottomBarWhenPushed = false
        viewController.navigationController?.pushViewController(themeViewController, animated: true)
    }

    func getDateAndTimeView() {
        guard let viewController = viewController else {
            return
        }
        
        let dateAndTimeContainer = DateAndTimeContainer.assemble(with: .init())
        let dateAndTimeViewController = dateAndTimeContainer.viewController
        
        dateAndTimeViewController.modalPresentationStyle = .overFullScreen
        viewController.navigationController?.pushViewController(dateAndTimeViewController, animated: true)
    }
    
    func getUnitsView() {
        guard let viewController = viewController else {
            return
        }
        
        let unitsContainer = UnitsContainer.assemble(with: .init())
        let unitsViewController = unitsContainer.viewController
        
        unitsViewController.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(unitsViewController, animated: true)
    }
    
    func getProfileView() {
        guard let viewController = viewController else {
            return
        }
        
        let profileContainer = ProfileContainer.assemble(with: .init())
        let profileViewController = profileContainer.viewController
        
        profileViewController.modalPresentationStyle = .overFullScreen
        viewController.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func getHealthView() {
        guard let viewController = viewController else {
            return
        }
        
        let healthContainer = HealthContainer.assemble(with: .init())
        let healthViewController = healthContainer.viewController
        
        healthViewController.modalPresentationStyle = .overFullScreen
        viewController.navigationController?.pushViewController(healthViewController, animated: true)
    }
}
