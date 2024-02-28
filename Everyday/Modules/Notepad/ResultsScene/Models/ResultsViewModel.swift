//
//  ResultsViewModel.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit

struct ResultsViewModel {
    let title: NSAttributedString
    let restTitle: NSAttributedString
    let continueTitle: NSAttributedString
    
    init() {
        let titleLabelTitle = "Результаты"
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let restButtonTitle = "Отдых"
        let restButtonAttributedString = NSAttributedString(string: restButtonTitle, attributes: Styles.titleAttributes)
        let continueButtonTitle = "Продолжить"
        let continueButtonAttributedString = NSAttributedString(string: continueButtonTitle, attributes: Styles.titleAttributes)
        
        self.title = titleLabelAttributedString
        self.restTitle = restButtonAttributedString
        self.continueTitle = continueButtonAttributedString
    }
}

private extension ResultsViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
}
