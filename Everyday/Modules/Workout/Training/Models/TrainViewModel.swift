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
    
    let infoLabel: NSAttributedString
    let levelLabel: NSAttributedString
    let timeLabel: NSAttributedString
    let countLabel: NSAttributedString
    
    init(infoLabel: String, levelLabel: String, timeLabel: String, countLabel: String) {
        self.buttonTitle = "Загрузить"
        self.levelDescriptionLabel = NSAttributedString(string: "Сложность", attributes: Styles.descriptionAttributes)
        self.timeDescriptionLabel = NSAttributedString(string: "Длительность", attributes: Styles.descriptionAttributes)
        self.countDescriptionLabel = NSAttributedString(string: "Тренировок", attributes: Styles.descriptionAttributes)
        
        self.infoLabel = NSAttributedString(string: infoLabel, attributes: Styles.titleAttributes)
        self.timeLabel = NSAttributedString(string: timeLabel, attributes: Styles.valueAttributes)
        self.levelLabel = NSAttributedString(string: levelLabel, attributes: Styles.valueAttributes)
        self.countLabel = NSAttributedString(string: countLabel, attributes: Styles.valueAttributes)
    }
}

extension TrainViewModel {
    struct Styles {
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "SpaceGray") ?? .black,
            .font: UIFont(name: "Arial-Black", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)
        ]
        
        static let valueAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "SpaceGray") ?? .black,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
    }
}
