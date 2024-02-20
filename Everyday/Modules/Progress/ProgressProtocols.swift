//
//  ProgressProtocols.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

protocol ProgressModuleInput {
    var moduleOutput: ProgressModuleOutput? { get }
}

protocol ProgressModuleOutput: AnyObject {
}

protocol ProgressViewInput: AnyObject {
}

protocol ProgressViewOutput: AnyObject {
}

protocol ProgressInteractorInput: AnyObject {
}

protocol ProgressInteractorOutput: AnyObject {
}

protocol ProgressRouterInput: AnyObject {
}
