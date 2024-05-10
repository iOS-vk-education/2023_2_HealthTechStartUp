//
//  NotepadEmptyStateViewModel.swift
//  Everyday
//
//  Created by Alexander on 10.05.2024.
//

import UIKit

struct NotepadEmptyStateViewModel {
    let title: NSAttributedString
    let logoImage: UIImage?
    
    init() {
        let titleLabelTitle = "NotepadEmptyState_title".localized
        let titleLabelAttributedString = NSAttributedString(string: titleLabelTitle, attributes: Styles.titleAttributes)
        let imageName = "logo"
        let image = UIImage(named: imageName)
        
        self.title = titleLabelAttributedString
        self.logoImage = image
    }
}

private extension NotepadEmptyStateViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 30, weight: .regular)
        ]
    }
}
