//
//  SheetPresenter+HeartRateVariabilityViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

extension SheetPresenter: HeartRateVariabilityViewOutput {
    func didTapSaveButton(with heartRateVariability: HeartRateVariability?) {
        print("[DEBUG] heart save button")
        let heartRateVariabilityModel = HeartRateVariabilityModel(heartRateVariability: heartRateVariability)
        let moduleType = SheetType.heartRateVariability(model: heartRateVariabilityModel)
        moduleOutput?.setResult(moduleType, at: 2)
        router.dismissSheet()
    }
    
    func didTapHeartRateVariabilityCloseButton() {
        router.dismissSheet()
    }
}
