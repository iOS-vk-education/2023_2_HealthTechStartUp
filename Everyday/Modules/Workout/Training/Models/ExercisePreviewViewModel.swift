//
//  ExercisePreviewViewModel.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import UIKit

struct ExercisePreviewViewModel {
    let title: NSAttributedString
    let level: NSAttributedString
    let image: UIImage
    
    init(title: String, level: String, image: UIImage) {
        self.title = NSAttributedString(string: title, attributes: Styles.titleAttributes)
        self.level = NSAttributedString(string: level, attributes: Styles.levelAttributes)
        self.image = image
    }
}

extension ExercisePreviewViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        static let levelAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 22)
        ]
    }
}
