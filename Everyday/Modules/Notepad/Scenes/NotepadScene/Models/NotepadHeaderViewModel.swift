//
//  NotepadHeaderViewModel.swift
//  Everyday
//
//  Created by user on 02.03.2024.
//

import UIKit

struct NotepadHeaderViewModel {
    let title: NSAttributedString
    let desciption: NSAttributedString
    let collapseImage: UIImage?
    
    init(workoutDay: WorkoutDay) {
        let titleLabelTitle = workoutDay.workout.name
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let desciptionLabelTitle = workoutDay.workout.name
        let desciptionLabelAttributedString = NSAttributedString(string: desciptionLabelTitle, attributes: Styles.desciptionAttributes)
        let collapseButtonImageName = "chevron.down"
        let collapseButtonImage = UIImage(systemName: collapseButtonImageName)
        
        self.title = titleLabelAttributedString
        self.desciption = desciptionLabelAttributedString
        self.collapseImage = collapseButtonImage
    }
}

private extension NotepadHeaderViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        
        static let desciptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.grayElement,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
}
