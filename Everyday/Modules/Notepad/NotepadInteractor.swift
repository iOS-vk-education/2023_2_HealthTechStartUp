//
//  NotepadInteractor.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

final class NotepadInteractor {
    weak var output: NotepadInteractorOutput?
}

extension NotepadInteractor: NotepadInteractorInput {
}
