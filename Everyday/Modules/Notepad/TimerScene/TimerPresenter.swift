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
    private var remainingTime: Int = Constants.defaultTime
    private var isActive: Bool = false
    
    init(router: TimerRouterInput, interactor: TimerInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

private extension TimerPresenter {
    
    // MARK: - Helpers
    
    func secondsToMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        ((seconds / 60), (seconds % 60))
    }
    
    func makeTimeString(_ minutes: Int, _ seconds: Int) -> String {
        String(format: "%02d", minutes) + " : " + String(format: "%02d", seconds)
    }
    
    func fromSecondsToTimeString(_ seconds: Int) -> String {
        let minutesSeconds = secondsToMinutesSeconds(seconds)
        let timeString = makeTimeString(minutesSeconds.0, minutesSeconds.1)
        return timeString
    }
    
    // MARK: - Actions
    
    @objc
    func step() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            timer.invalidate()
        }
        
        let timeString = fromSecondsToTimeString(remainingTime)
        view?.updateRemainingTime(with: timeString)
    }
}

extension TimerPresenter: TimerModuleInput {
}

extension TimerPresenter: TimerViewOutput {
    func didLoadView() {
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = TimerViewModel(remainingTime: timeString)
        view?.configure(with: viewModel)
    }
    
    func didTapStartButton() {
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = TimerViewModel(remainingTime: timeString)
        if !isActive {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
            view?.changeMainButtonImage(with: viewModel.pauseImage)
        } else {
            timer.invalidate()
            view?.changeMainButtonImage(with: viewModel.playImage)
        }
        isActive.toggle()
    }
    
    func didTapResetButton() {
        timer.invalidate()
        remainingTime = Constants.defaultTime
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = TimerViewModel(remainingTime: timeString)
        isActive = false
        view?.changeMainButtonImage(with: viewModel.playImage)
        view?.updateRemainingTime(with: timeString)
    }
    
    func didTapCloseButton() {
        router.closeTimer()
    }
}

extension TimerPresenter: TimerInteractorOutput {
}

// MARK: - Constants

private extension TimerPresenter {
    struct Constants {
        static let defaultTime: Int = 2
    }
}
