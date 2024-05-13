//
//  ChangeLanguageProtocols.swift
//  Everyday
//
//  Created by Yaz on 05.05.2024.
//  
//

import Foundation

protocol ChangeLanguageModuleInput {
    var moduleOutput: ChangeLanguageModuleOutput? { get }
}

protocol ChangeLanguageModuleOutput: AnyObject {
}

protocol ChangeLanguageViewInput: AnyObject {
    func configure(with: ChangeLanguageViewModel)
}

protocol ChangeLanguageViewOutput: AnyObject {
    func didLoadView()
    func getChangeLanguageViewModel() -> ChangeLanguageViewModel
    func didSwipe()
    
    func didTapEnCell()
    func didTapRuCell()
    func getCurrentLanguageIndexPath() -> IndexPath
}

protocol ChangeLanguageRouterInput: AnyObject {
    func getBackToMainView()
}
