//
//  WalkProgramsViewModel.swift
//  workout
//
//  Created by Михаил on 01.04.2024.
//

import UIKit

struct WalkProgramsViewModel {
    let title: NSAttributedString
    let image: String
    
    init() {
        self.image = "WalkProgram"
        self.title = NSAttributedString(string: "WalkPrograms_title".localized, attributes: Styles.titleAttributes)
    }
}

private extension WalkProgramsViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "SpaceGray") ?? .black,
            .font: UIFont(name: "Arial-Black", size: 46) ?? UIFont.boldSystemFont(ofSize: 46)
        ]
    }
}
