//
//  NotificationModel.swift
//  Everyday
//
//  Created by Yaz on 17.05.2024.
//

import UIKit

enum NotificationType {
    case tomorrowTraining
    case preTrainingWarning
}

struct NotificationServiceNotificationModel {
    let title: String
    let body: String
    
    init(notificationType: NotificationType) {
        switch notificationType {
        case .tomorrowTraining:
            self.title = "Завтра тренировка"
            self.body = "Хорошенько выспись"
        case .preTrainingWarning:
            self.title = "У тебя сегодня тренировка!"
            self.body = "Не забудь прихватить с собой воды \nКоманда Everyday верит в тебя"
        }
    }
}
