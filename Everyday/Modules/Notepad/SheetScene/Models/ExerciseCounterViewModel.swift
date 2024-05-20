//
//  ExerciseCounterViewModel.swift
//  Everyday
//
//  Created by Alexander on 10.05.2024.
//

import UIKit

struct ExerciseCounterViewModel {
    let title: String
    let resultTitle: NSAttributedString
    let minusImage: UIImage?
    let plusImage: UIImage?
    let closeImage: UIImage?
    let saveImage: UIImage?
    
    init(exercise: Exercise) {
        let resultLabelTitle = exercise.result
        let resultLabelAttributedString = NSAttributedString(string: resultLabelTitle, attributes: Styles.resultAttributes)
        let minusButtonImageName = "minus.circle.fill"
        let minusButtonImage = UIImage(systemName: minusButtonImageName, withConfiguration: Configurations.huge)
        let plusButtonImageName = "plus.circle.fill"
        let plusButtonImage = UIImage(systemName: plusButtonImageName, withConfiguration: Configurations.huge)
        let closeButtonImageName = "xmark.circle.fill"
        let closeButtonImage = UIImage(systemName: closeButtonImageName, withConfiguration: Configurations.large)
        let saveButtonImageName = "checkmark.circle.fill"
        let saveButtonImage = UIImage(systemName: saveButtonImageName, withConfiguration: Configurations.large)
        
        self.title = exercise.name
        self.resultTitle = resultLabelAttributedString
        self.minusImage = minusButtonImage
        self.plusImage = plusButtonImage
        self.closeImage = closeButtonImage
        self.saveImage = saveButtonImage
    }
}

private extension ExerciseCounterViewModel {
    struct Styles {
        static let resultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 72, weight: .bold),
            .foregroundColor: UIColor.Text.primary
        ]
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.Text.primary
        ]
    }
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        static let huge = UIImage.SymbolConfiguration(pointSize: 56)
    }
}
