//
//  TrainingTableViewCellViewModel.swift
//  Everyday
//
//  Created by user on 02.03.2024.
//

import UIKit

struct TrainingTableViewCellViewModel {
    let title: NSAttributedString
    let result: NSAttributedString
    let startTitle: NSAttributedString
    
    init(exercise: Exercise) {
        let titleLabelTitle = exercise.name
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let resultLabelTitle = exercise.result
        let resultLabelAttributedString = NSAttributedString(string: resultLabelTitle, attributes: Styles.resultAttributes)
        let startButtonTitle = "Начать"
        let startButtonAttributedString = NSAttributedString(string: startButtonTitle, attributes: Styles.titleAttributes)
        
        self.title = titleLabelAttributedString
        self.result = resultLabelAttributedString
        self.startTitle = startButtonAttributedString
    }
}

private extension TrainingTableViewCellViewModel {
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
