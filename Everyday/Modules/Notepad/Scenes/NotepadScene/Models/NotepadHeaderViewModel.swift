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
    
    init(workout: Workout) {
        let titleLabelTitle = workout.workoutName
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let desciptionLabelTitle = workout.dayName
        let desciptionLabelAttributedString = NSAttributedString(string: desciptionLabelTitle, attributes: Styles.desciptionAttributes)
        let collapseButtonImageName = "chevron.down.circle.fill"
        let collapseButtonImage = UIImage(systemName: collapseButtonImageName, withConfiguration: Configurations.large)
        
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
    
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .title1)
    }
}
