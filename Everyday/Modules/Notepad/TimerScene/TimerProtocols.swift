//
//  TimerProtocols.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

protocol TimerModuleInput {
    var moduleOutput: TimerModuleOutput? { get }
}

protocol TimerModuleOutput: AnyObject {
}

protocol TimerViewInput: AnyObject {
    func configure(with viewModel: TimerViewModel)
    func updateRemainingTime(with time: Int)
}

protocol TimerViewOutput: AnyObject {
    func didLoadView()
    func didTapStartButton()
    func didTapStopButton()
    func didTapResetButton()
    func didTapSkipButton()
}

protocol TimerInteractorInput: AnyObject {
}

protocol TimerInteractorOutput: AnyObject {
}

protocol TimerRouterInput: AnyObject {
    func closeTimer()
}
