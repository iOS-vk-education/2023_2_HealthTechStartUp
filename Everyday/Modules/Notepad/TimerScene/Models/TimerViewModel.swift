//
//  TimerViewModel.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit

struct TimerViewModel {
    let remainingTimeTitle: NSAttributedString
    let startTitle: NSAttributedString
    let stopTitle: NSAttributedString
    let resetTitle: NSAttributedString
    let skipTitle: NSAttributedString
    
    init(remainingTime: Int) {
        let remainingTimeLabelTitle = "\(remainingTime)"
        let remainingTimeLabelAttributedString = NSAttributedString(string: remainingTimeLabelTitle, attributes: Styles.titleAttributes)
        let startButtonTitle = "Старт"
        let startButtonAttributedString = NSAttributedString(string: startButtonTitle, attributes: Styles.titleAttributes)
        let stopButtonTitle = "Стоп"
        let stopButtonAttributedString = NSAttributedString(string: stopButtonTitle, attributes: Styles.titleAttributes)
        let resetButtonTitle = "Заново"
        let resetButtonAttributedString = NSAttributedString(string: resetButtonTitle, attributes: Styles.titleAttributes)
        let skipButtonTitle = "Пропустить"
        let skipButtonAttributedString = NSAttributedString(string: skipButtonTitle, attributes: Styles.titleAttributes)
        
        self.remainingTimeTitle = remainingTimeLabelAttributedString
        self.startTitle = startButtonAttributedString
        self.stopTitle = stopButtonAttributedString
        self.resetTitle = resetButtonAttributedString
        self.skipTitle = skipButtonAttributedString
    }
}

private extension TimerViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
}
