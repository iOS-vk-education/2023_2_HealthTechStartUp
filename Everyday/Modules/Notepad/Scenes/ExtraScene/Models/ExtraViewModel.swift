//
//  ExtraViewModel.swift
//  Everyday
//
//  Created by Alexander on 09.04.2024.
//

import UIKit

struct ExtraViewModel {
    let finishTitle: NSAttributedString
    
    init(isFinish: Bool = false) {
        let finishButtonTitle = isFinish ? "Training_Finish_Button_Title" : "Skip"
        let finishButtonAttributedString = NSAttributedString(string: finishButtonTitle.localized, attributes: Styles.titleAttributes)
        
        self.finishTitle = finishButtonAttributedString
    }
}

private extension ExtraViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
}
