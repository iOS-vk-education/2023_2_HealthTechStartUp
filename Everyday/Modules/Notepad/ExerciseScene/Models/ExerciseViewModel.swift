//
//  ExerciseViewModel.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit

struct ExerciseViewModel {
    let title: String
    let resultTitle: NSAttributedString
    let saveTitle: NSAttributedString
    
    init(exercise: Exercise) {
        let resultLabelTitle = "0"
        let resultLabelAttributedString = NSAttributedString(string: resultLabelTitle, attributes: Styles.titleAttributes)
        let saveButtonTitle = "Сохранить"
        let saveButtonAttributedString = NSAttributedString(string: saveButtonTitle, attributes: Styles.titleAttributes)
        
        self.title = exercise.name
        self.resultTitle = resultLabelAttributedString
        self.saveTitle = saveButtonAttributedString
    }
}

private extension ExerciseViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
}
