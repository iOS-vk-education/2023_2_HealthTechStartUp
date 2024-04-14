//
//  SheetViewModel.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit

struct SheetViewModel {
    let title: NSAttributedString
    let closeImage: UIImage?
    let saveImage: UIImage?
    
    init() {
        let titleLabelTitle = "Title"
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let closeButtonImageName = "xmark.circle.fill"
        let closeButtonImage = UIImage(systemName: closeButtonImageName, withConfiguration: Configurations.large)
        let saveButtonImageName = "checkmark.circle.fill"
        let saveButtonImage = UIImage(systemName: saveButtonImageName, withConfiguration: Configurations.large)
        
        self.title = titleLabelAttributedString
        self.closeImage = closeButtonImage
        self.saveImage = saveButtonImage
    }
}

private extension SheetViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
