//
//  ScheduleViewModel.swift
//  Everyday
//
//  Created by Михаил on 20.05.2024.
//

import UIKit

struct ScheduleViewModel {
    let title: NSAttributedString
    let schedule: [NSAttributedString]
        
    init() {
        self.title = NSAttributedString(string: "Выберите дни тренировок", attributes: Styles.titleAttributes)
        
        self.schedule = [NSAttributedString(string: "Пн", attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "Вт", attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "Ср", attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "Чт", attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "Пт", attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "Сб", attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "Вс", attributes: Styles.scheduleAttributes)
                        ]
    }
}

extension ScheduleViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 22)
        ]
        
        static let scheduleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}
