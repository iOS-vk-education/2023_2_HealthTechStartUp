//
//  NotepadPresenter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

final class NotepadPresenter {
    weak var view: NotepadViewInput?
    weak var moduleOutput: NotepadModuleOutput?
    
    private let router: NotepadRouterInput
    private let interactor: NotepadInteractorInput
    
    init(router: NotepadRouterInput, interactor: NotepadInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NotepadPresenter: NotepadModuleInput {
}

extension NotepadPresenter: NotepadViewOutput {
}

extension NotepadPresenter: NotepadInteractorOutput {
}
