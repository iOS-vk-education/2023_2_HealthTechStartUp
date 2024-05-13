//
//  WalkProgramsProtocols.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import Foundation

protocol WalkProgramsModuleInput {
    var moduleOutput: WalkProgramsModuleOutput? { get }
}

protocol WalkProgramsModuleOutput: AnyObject {
}

protocol WalkProgramsViewInput: AnyObject {
    func configure(with: WalkProgramsViewModel)
}

protocol WalkProgramsViewOutput: AnyObject {
    func didLoadView()
}

protocol WalkProgramsInteractorInput: AnyObject {
}

protocol WalkProgramsInteractorOutput: AnyObject {
}

protocol WalkProgramsRouterInput: AnyObject {
}
