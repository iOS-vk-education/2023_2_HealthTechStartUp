//
//  NotepadViewModel.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit

struct NotepadViewModel {
    let stateTitle: NSAttributedString
    let barButtonImage: UIImage?
    
    init(isResult: Bool) {
        let stateLabelTitle = isResult ? "Journal_Results_Title" : "Journal_Plan_Title"
        let stateLabelAttributedString = NSAttributedString(string: stateLabelTitle.localized, attributes: Styles.titleAttributes)
        let barButtonImageName = "bookmark"
        let barButtonImage = UIImage(systemName: barButtonImageName)
        
        self.stateTitle = stateLabelAttributedString
        self.barButtonImage = barButtonImage
    }
}

private extension NotepadViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 24, weight: .regular)
        ]
    }
}
