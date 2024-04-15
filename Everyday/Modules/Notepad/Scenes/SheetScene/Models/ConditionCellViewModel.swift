//
//  ConditionCellViewModel.swift
//  Everyday
//
//  Created by Alexander on 13.04.2024.
//

import UIKit

struct ConditionCellViewModel {
    let title: NSAttributedString
    let conditionImage: UIImage?
    
    init(condition: Condition) {
        let titleLabelTitle = String(describing: condition).uppercased()
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let conditionImageName = condition.rawValue
        let conditionImage = UIImage(systemName: conditionImageName, withConfiguration: Configurations.large)
        
        self.title = titleLabelAttributedString
        self.conditionImage = conditionImage
    }
}

private extension ConditionCellViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.Text.grayElement
        ]
    }
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
