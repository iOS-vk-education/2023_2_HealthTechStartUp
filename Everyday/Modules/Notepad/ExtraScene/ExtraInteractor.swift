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
    func saveProgress(_ progress: WorkoutProgress) {
        self.output?.didStartLoading()
        
        Task {
            do {
                try await dayManager.postProgress(progress)
                self.output?.didEndLoading()
                self.output?.didPostData()
            } catch {
                self.output?.didEndLoading()
                throw CustomError.progressPostError
            }
        }
    }
}
