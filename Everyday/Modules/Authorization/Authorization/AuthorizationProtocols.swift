//
//  AuthorizationProtocols.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import Foundation

protocol AuthorizationModuleInput {
    var moduleOutput: AuthorizationModuleOutput? { get }
}

protocol AuthorizationModuleOutput: AnyObject {
}

protocol AuthorizationViewInput: AnyObject {
}

protocol AuthorizationViewOutput: AnyObject {
}

protocol AuthorizationInteractorInput: AnyObject {
}

protocol AuthorizationInteractorOutput: AnyObject {
}

protocol AuthorizationRouterInput: AnyObject {
}
