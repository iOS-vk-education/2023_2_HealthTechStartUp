//
//  EmptyUserProgramsViewModel.swift
//  Everyday
//
//  Created by Михаил on 20.05.2024.
//

import UIKit

struct EmptyUserProgramsViewModel {
    let title: NSAttributedString
    let description: NSAttributedString
        
    init(title: String) {
        self.title = NSAttributedString(string: title, attributes: Styles.titleAttributes)
        self.description = NSAttributedString(string: "EmptyTrainViewModel1".localized, attributes: Styles.descriptionAttributes)
    }
}

extension EmptyUserProgramsViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 26)
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont(name: "Arial-Black", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        ]
    }
}
