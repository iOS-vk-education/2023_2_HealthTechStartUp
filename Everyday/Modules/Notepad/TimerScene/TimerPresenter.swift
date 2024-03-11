//
//  TimerPresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

final class TimerPresenter {
    weak var view: TimerViewInput?
    weak var moduleOutput: TimerModuleOutput?
    
    private let router: TimerRouterInput
    private let interactor: TimerInteractorInput
    
    private var timer = Timer()
    private var remainingTime: Int = 1
    
    init(router: TimerRouterInput, interactor: TimerInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

private extension TimerPresenter {
    
    // MARK: - Actions
    
    @objc
    func step() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            timer.invalidate()
        }
        
        view?.updateRemainingTime(with: remainingTime)
    }
}

extension TimerPresenter: TimerModuleInput {
}

extension TimerPresenter: TimerViewOutput {
    func didLoadView() {
        let viewModel = TimerViewModel(remainingTime: remainingTime)
        view?.configure(with: viewModel)
    }
    
    func didTapStartButton() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    func didTapStopButton() {
        timer.invalidate()
    }
    
    func didTapResetButton() {
        timer.invalidate()
        remainingTime = 1
        view?.updateRemainingTime(with: remainingTime)
    }
    
    func didTapSkipButton() {
        router.closeTimer()
    }
}

extension TimerPresenter: TimerInteractorOutput {
}
