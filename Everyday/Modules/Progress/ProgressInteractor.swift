//
//  ProgressInteractor.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

final class ProgressInteractor {
    weak var output: ProgressInteractorOutput?
}

extension ProgressInteractor: ProgressInteractorInput {
}
