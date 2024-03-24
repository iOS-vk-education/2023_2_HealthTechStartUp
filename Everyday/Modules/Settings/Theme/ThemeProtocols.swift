//
//  ThemeProtocols.swift
//  Everyday
//
//  Created by Yaz on 08.03.2024.
//
//

import Foundation

protocol ThemeModuleInput {
    var moduleOutput: ThemeModuleOutput? { get }
}

protocol ThemeModuleOutput: AnyObject {
}

protocol ThemeViewInput: AnyObject {
}

protocol ThemeViewOutput: AnyObject {
    func getBack()
}

protocol ThemeInteractorInput: AnyObject {
}

protocol ThemeInteractorOutput: AnyObject {
}

protocol ThemeRouterInput: AnyObject {
    func getBackToMainView()
}
