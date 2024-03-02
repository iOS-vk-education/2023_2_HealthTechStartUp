//
//  ResultsViewModel.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit

struct ResultsViewModel {
    let resultsTitle: NSAttributedString
    let restTitle: NSAttributedString
    let continueTitle: NSAttributedString
    let closeImage: UIImage?
    
    init() {
        let resultsLabelTitle = "Результаты"
        let resultsLabelAttributedString = NSAttributedString(string: resultsLabelTitle, attributes: Styles.titleAttributes)
        let restButtonTitle = "Отдых"
        let restButtonAttributedString = NSAttributedString(string: restButtonTitle, attributes: Styles.buttonTitleAttributes)
        let continueButtonTitle = "Продолжить"
        let continueButtonAttributedString = NSAttributedString(string: continueButtonTitle, attributes: Styles.buttonTitleAttributes)
        let closeButtonImageName = "xmark.circle.fill"
        let closeButtonImage = UIImage(systemName: closeButtonImageName, withConfiguration: Configurations.large)
        
        self.resultsTitle = resultsLabelAttributedString
        self.restTitle = restButtonAttributedString
        self.continueTitle = continueButtonAttributedString
        self.closeImage = closeButtonImage
    }
}

private extension ResultsViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .regular)
        ]
        
        static let buttonTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
