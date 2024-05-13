//
//  ProgramsProtocols.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import Foundation

protocol ProgramsModuleInput {
    var moduleOutput: ProgramsModuleOutput? { get }
}

protocol ProgramsModuleOutput: AnyObject {
}

protocol ProgramsViewInput: AnyObject {
    func setup(with items: [ProgramsSectionItem])
}

protocol ProgramsViewOutput: AnyObject {
    func didLoadView()
}

protocol ProgramsInteractorInput: AnyObject {
}

protocol ProgramsInteractorOutput: AnyObject {
}

protocol ProgramsRouterInput: AnyObject {
}
