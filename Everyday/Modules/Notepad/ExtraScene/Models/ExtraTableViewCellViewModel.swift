//
//  ExtraTableViewCellViewModel.swift
//  Everyday
//
//  Created by Alexander on 09.04.2024.
//

import UIKit

struct ExtraTableViewCellViewModel {
    let title: NSAttributedString
    let result: NSAttributedString
    let number: NSAttributedString
    let circle: UIImage?
    let circleFilled: UIImage?
    
    init(exercise: Exercise) {
        let titleLabelTitle = exercise.name
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let resultLabelTitle = exercise.result
        let resultLabelAttributedString = NSAttributedString(string: resultLabelTitle, attributes: Styles.resultAttributes)
        let numberLabelTitle = "0"
        let numberLabelAttributedString = NSAttributedString(string: numberLabelTitle, attributes: Styles.resultAttributes)
        let circleImageName = "circle"
        let circleImage = UIImage(systemName: circleImageName, withConfiguration: Configurations.large)
        let circleFilledImageName = "circle.fill"
        let circleFilledImage = UIImage(systemName: circleFilledImageName, withConfiguration: Configurations.large)
        
        self.title = titleLabelAttributedString
        self.result = resultLabelAttributedString
        self.number = numberLabelAttributedString
        self.circle = circleImage
        self.circleFilled = circleFilledImage
    }
}

private extension ExtraTableViewCellViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        
        static let resultAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
