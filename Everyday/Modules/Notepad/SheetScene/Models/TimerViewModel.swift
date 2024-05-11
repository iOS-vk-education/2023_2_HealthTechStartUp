//
//  TimerViewModel.swift
//  Everyday
//
//  Created by Alexander on 11.05.2024.
//

import UIKit

struct TimerViewModel {
    let remainingTimeTitle: NSAttributedString
    let exrtaTimeTitle: NSAttributedString
    let resetTitle: NSAttributedString
    let playImage: UIImage?
    let pauseImage: UIImage?
    let closeImage: UIImage?
    let saveImage: UIImage?
    
    init(remainingTime: String) {
        let remainingTimeLabelTitle = "\(remainingTime)"
        let remainingTimeLabelAttributedString = NSAttributedString(string: remainingTimeLabelTitle, attributes: Styles.timeAttributes)
        let exrtaTimeButtonTitle = "+1:00"
        let exrtaTimeButtonAttributedString = NSAttributedString(string: exrtaTimeButtonTitle, attributes: Styles.titleAttributes)
        let resetButtonTitle = "Заново"
        let resetButtonAttributedString = NSAttributedString(string: resetButtonTitle, attributes: Styles.titleAttributes)
        let playButtonImageName = "play.circle.fill"
        let playButtonImage = UIImage(systemName: playButtonImageName, withConfiguration: Configurations.huge)
        let pauseButtonImageName = "pause.circle.fill"
        let pauseButtonImage = UIImage(systemName: pauseButtonImageName, withConfiguration: Configurations.huge)
        let closeButtonImageName = "xmark.circle.fill"
        let closeButtonImage = UIImage(systemName: closeButtonImageName, withConfiguration: Configurations.large)
        let saveButtonImageName = "checkmark.circle.fill"
        let saveButtonImage = UIImage(systemName: saveButtonImageName, withConfiguration: Configurations.large)
        
        self.remainingTimeTitle = remainingTimeLabelAttributedString
        self.exrtaTimeTitle = exrtaTimeButtonAttributedString
        self.resetTitle = resetButtonAttributedString
        self.playImage = playButtonImage
        self.pauseImage = pauseButtonImage
        self.closeImage = closeButtonImage
        self.saveImage = saveButtonImage
    }
}

private extension TimerViewModel {
    struct Styles {
        static let timeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 72, weight: .bold),
            .foregroundColor: UIColor.Text.primary
        ]
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.Text.primary
        ]
    }
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        static let huge = UIImage.SymbolConfiguration(pointSize: 56)
    }
}
