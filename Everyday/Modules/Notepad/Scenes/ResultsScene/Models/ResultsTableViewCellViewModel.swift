//
//  ResultsTableViewCellViewModel.swift
//  Everyday
//
//  Created by user on 02.03.2024.
//

import UIKit

struct ResultsTableViewCellViewModel {
    let exerciseName: NSAttributedString
    let result: NSAttributedString
    let minusImage: UIImage?
    let plusImage: UIImage?
    
    init(exercise: NewExercise) {
        let exerciseNameLabelTitle = exercise.name
        let exerciseNameLabelAttributedString = NSAttributedString(string: exerciseNameLabelTitle, attributes: Styles.titleAttributes)
        let resultLabelTitle = exercise.result
        let resultLabelAttributedString = NSAttributedString(string: resultLabelTitle, attributes: Styles.resultAttributes)
        let minusButtonImageName = "minus"
        let minusButtonImage = UIImage(systemName: minusButtonImageName)
        let plusButtonImageName = "plus"
        let plusButtonImage = UIImage(systemName: plusButtonImageName)
        
        self.exerciseName = exerciseNameLabelAttributedString
        self.result = resultLabelAttributedString
        self.minusImage = minusButtonImage
        self.plusImage = plusButtonImage
    }
}

private extension ResultsTableViewCellViewModel {
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
}
