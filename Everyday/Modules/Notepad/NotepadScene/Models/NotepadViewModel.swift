//
//  NotepadViewModel.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit

struct NotepadViewModel {
    let stateTitle: NSAttributedString
    
    init(isResult: Bool) {
        let stateLabelTitle = isResult ? "Результат" : "Ваш план"
        let stateLabelAttributedString = NSAttributedString(string: stateLabelTitle, attributes: Styles.titleAttributes)
        
        self.stateTitle = stateLabelAttributedString
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
