//
//  SheetViewModel.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit

struct SheetViewModel {
    let title: NSAttributedString
    let backgroundColor: UIColor
    let closeImage: UIImage?
    let saveImage: UIImage?
    
    init(sheetType: SheetType) {
        let titleLabelTitle = "Title"  // make good
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        var backgroundColor: UIColor = Constants.defaultBackgroundColor
        switch sheetType {
        case .camera:
            backgroundColor = Constants.transparentBackgroundColor
        case .heartRateVariability:
            backgroundColor = Constants.transparentBackgroundColor
        default:
            break
        }
        let closeButtonImageName = "xmark.circle.fill"
        let closeButtonImage = UIImage(systemName: closeButtonImageName, withConfiguration: Configurations.large)
        let saveButtonImageName = "checkmark.circle.fill"
        let saveButtonImage = UIImage(systemName: saveButtonImageName, withConfiguration: Configurations.large)
        
        self.title = titleLabelAttributedString
        self.backgroundColor = backgroundColor
        self.closeImage = closeButtonImage
        self.saveImage = saveButtonImage
    }
}

private extension SheetViewModel {
    struct Constants {
        static let defaultBackgroundColor: UIColor = .background
        static let transparentBackgroundColor: UIColor = .black.withAlphaComponent(0.5)
    }
    
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
