//
//  HeartRateInteractor.swift
//  AI_Everyday
//
//  Created by Михаил on 11.05.2024.
//
//

import Foundation
import BeamAISDK

final class HeartRateInteractor {
    weak var output: HeartRateInteractorOutput?
}

extension HeartRateInteractor: HeartRateInteractorInput {
    func checkBeam() {
        do {
            let beamAI = try BeamAI(beamID: "kNDiGPo50VzMZtT2Kb0E", frameRate: 30, window: 60.0, updateEvery: 1.0)
            output?.didCheckBeam(with: beamAI)
        } catch {
            output?.didCheckBeam(with: error)
        }
    }
}
