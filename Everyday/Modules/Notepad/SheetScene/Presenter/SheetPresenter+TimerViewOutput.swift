//
//  SheetPresenter+TimerViewOutput.swift
//  Everyday
//
//  Created by Alexander on 11.05.2024.
//

import Foundation

extension SheetPresenter: TimerViewOutput {
    func didTapTimerSaveButton(with seconds: Int) {
        router.dismissSheet()
    }
    
    func didTapTimerCloseButton() {
        router.dismissSheet()
    }
}
