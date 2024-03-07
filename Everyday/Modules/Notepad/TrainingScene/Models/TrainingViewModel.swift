//
//  TrainingViewModel.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit

struct TrainingViewModel {
    let finishTitle: NSAttributedString
    
    init() {
        let finishButtonTitle = "Закончить"
        let finishButtonAttributedString = NSAttributedString(string: finishButtonTitle, attributes: Styles.titleAttributes)
        
        self.finishTitle = finishButtonAttributedString
    }
}

private extension TrainingViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
}
