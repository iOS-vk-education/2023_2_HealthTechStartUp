//
//  ExtraProtocols.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

protocol ExtraModuleInput {
    var moduleOutput: ExtraModuleOutput? { get }
}

protocol ExtraModuleOutput: AnyObject {
}

protocol ExtraViewInput: AnyObject {
}

protocol ExtraViewOutput: AnyObject {
}

protocol ExtraInteractorInput: AnyObject {
}

protocol ExtraInteractorOutput: AnyObject {
}

protocol ExtraRouterInput: AnyObject {
}
