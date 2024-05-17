//
//  TrainViewModel.swift
//  Everyday
//
//  Created by Михаил on 14.05.2024.
//

import UIKit

struct TrainViewModel {
    let buttonTitle: String
    let levelDescriptionLabel: NSAttributedString
    let countDescriptionLabel: NSAttributedString
    let timeDescriptionLabel: NSAttributedString
    
    init() {
        self.buttonTitle = "Загрузить"
        self.levelDescriptionLabel = NSAttributedString(string: "Сложность", attributes: Styles.descriptionAttributes)
        self.timeDescriptionLabel = NSAttributedString(string: "Длительность", attributes: Styles.descriptionAttributes)
        self.countDescriptionLabel = NSAttributedString(string: "Тренировок", attributes: Styles.descriptionAttributes)
    }
}

extension TrainViewModel {
    struct Styles {
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
    }
}
