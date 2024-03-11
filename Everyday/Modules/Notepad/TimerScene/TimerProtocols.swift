//
//  TimerProtocols.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

protocol TimerModuleInput {
    var moduleOutput: TimerModuleOutput? { get }
}

protocol TimerModuleOutput: AnyObject {
}

protocol TimerViewInput: AnyObject {
    func configure(with viewModel: TimerViewModel)
    func updateRemainingTime(with time: String)
    func changeMainButtonImage(with image: UIImage?)
}

protocol TimerViewOutput: AnyObject {
    func didLoadView()
    func didTapStartButton()
    func didTapResetButton()
    func didTapCloseButton()
}

protocol TimerInteractorInput: AnyObject {
}

protocol TimerInteractorOutput: AnyObject {
}

protocol TimerRouterInput: AnyObject {
    func closeTimer()
}
