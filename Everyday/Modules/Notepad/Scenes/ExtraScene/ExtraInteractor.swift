//
//  ExtraInteractor.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

final class ExtraInteractor {
    weak var output: ExtraInteractorOutput?
    private let dayManager: DayServiceDescription

    init(dayManager: DayServiceDescription = DayService.shared) {
        self.dayManager = dayManager
    }
}

extension ExtraInteractor: ExtraInteractorInput {
    func saveProgress(_ progress: NewWorkoutProgress) {
        self.output?.didStartLoading()
        
        dayManager.postProgress(progress) { [weak self] error in
            guard let self else {
                return
            }
            
            guard error == nil else {
                return
            }

            self.output?.didEndLoading()
            self.output?.didPostData()
        }
    }
}
