//
//  NotepadProtocols.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

protocol NotepadModuleInput {
    var moduleOutput: NotepadModuleOutput? { get }
}

protocol NotepadModuleOutput: AnyObject {
}

protocol NotepadViewInput: AnyObject {
}

protocol NotepadViewOutput: AnyObject {
}

protocol NotepadInteractorInput: AnyObject {
}

protocol NotepadInteractorOutput: AnyObject {
}

protocol NotepadRouterInput: AnyObject {
}
