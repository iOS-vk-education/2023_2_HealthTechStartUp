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
        let startButtonTitle = "Timer_Start_Button_Title"
        let startButtonAttributedString = NSAttributedString(string: startButtonTitle.localized, attributes: Styles.titleAttributes)
        let stopButtonTitle = "Timer_Stop_Button_Title"
        let stopButtonAttributedString = NSAttributedString(string: stopButtonTitle.localized, attributes: Styles.titleAttributes)
        let resetButtonTitle = "Timer_Restart_Button_Title"
        let resetButtonAttributedString = NSAttributedString(string: resetButtonTitle.localized, attributes: Styles.titleAttributes)
        let skipButtonTitle = "Timer_Skip_Button_Title"
        let skipButtonAttributedString = NSAttributedString(string: skipButtonTitle.localized, attributes: Styles.titleAttributes)
        
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
