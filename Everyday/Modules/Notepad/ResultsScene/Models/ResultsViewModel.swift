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
        let resultsLabelTitle = "Progress_title"
        let resultsLabelAttributedString = NSAttributedString(string: resultsLabelTitle.localized, attributes: Styles.titleAttributes)
        let restButtonTitle = "Results_Rest_Button_Title"
        let restButtonAttributedString = NSAttributedString(string: restButtonTitle.localized, attributes: Styles.buttonTitleAttributes)
        let continueButtonTitle = "Results_Continue_Button_Title"
        let continueButtonAttributedString = NSAttributedString(string: continueButtonTitle.localized, attributes: Styles.buttonTitleAttributes)
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
