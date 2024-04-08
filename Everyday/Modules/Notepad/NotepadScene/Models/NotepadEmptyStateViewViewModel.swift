//
//  NotepadEmptyStateViewViewModel.swift
//  Everyday
//
//  Created by Alexander on 09.04.2024.
//

import UIKit

struct NotepadEmptyStateViewViewModel {
    let title: NSAttributedString
    let logoImage: UIImage?
    
    init() {
        let titleLabelTitle = "Chilling..."
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let imageName = "logo"
        let image = UIImage(named: imageName)
        
        self.title = titleLabelAttributedString
        self.logoImage = image
    }
}

private extension NotepadEmptyStateViewViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 30, weight: .regular)
        ]
    }
}
