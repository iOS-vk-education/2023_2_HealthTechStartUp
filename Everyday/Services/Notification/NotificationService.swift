//
//  NotificationsService.swift
//  Everyday
//
//  Created by Yaz on 14.05.2024.
//

import Foundation
import UserNotifications
import UIKit

protocol NotificationsServiceDescription {
    func requestAuthorization()
    func createNotification(notificationType: NotificationType, identifier: String, trigger: UNNotificationTrigger) -> UNNotificationRequest
    func setPreTrainingNotification(nextTrainingDate: Date)
    func setTommorowTrainingNotification(nextTrainingDate: Date)
    func isNotificationSet(for identifier: String, completion: @escaping (Bool) -> Void)
    func setTrainingNotifications(nextTrainingDate: Date)
}

final class NotificationsService: NotificationsServiceDescription {

    static let shared = NotificationsService()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {
    }
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .alert]) { (granted, _) in
            
            guard granted else {
                return
            }
            
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else {
                    return
                }
            }
        }
    }
    
    func createNotification(notificationType: NotificationType, identifier: String, trigger: UNNotificationTrigger) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        
        let notificationModel = NotificationServiceNotificationModel(notificationType: notificationType)
        
        content.title = notificationModel.title
        content.body = notificationModel.body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        return request
    }
    
    func setPreTrainingNotification(nextTrainingDate: Date) {
        isNotificationSet(for: Constants.identifierForPreTrainingNotification) { isSet in
            if isSet {
                return
            } else {
                var components = Calendar.current.dateComponents([.year, .month, .day], from: nextTrainingDate)
                components.hour = Constants.timeForPreTrainingNotification.hour
                components.minute = Constants.timeForPreTrainingNotification.minut
                
                guard let notificationDate = Calendar.current.date(from: components) else {
                    return
                }
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                
                let identifier = Constants.identifierForPreTrainingNotification
                
                let request = self.createNotification(notificationType: .tomorrowTraining, identifier: identifier, trigger: trigger)
                self.notificationCenter.add(request)
            }
        }
    }
    
    func setTommorowTrainingNotification(nextTrainingDate: Date) {
        isNotificationSet(for: Constants.identifierForNextTrainingNotification) { isSet in
            if isSet {
                return
            } else {
                guard let notificationDate = Calendar.current.date(byAdding: .day, value: -1, to: nextTrainingDate) else {
                    return
                }
                
                var components = Calendar.current.dateComponents([.year, .month, .day], from: notificationDate)
                components.hour = Constants.timeForTomorrowTrainingNotification.hour
                components.minute = Constants.timeForTomorrowTrainingNotification.minut
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                
                let identifier = Constants.identifierForNextTrainingNotification
                
                let request = self.createNotification(notificationType: .tomorrowTraining, identifier: identifier, trigger: trigger)
                self.notificationCenter.add(request)
            }
        }
    }
    
    func isNotificationSet(for identifier: String, completion: @escaping (Bool) -> Void) {
        notificationCenter.getPendingNotificationRequests { requests in
            let isSet = requests.contains { request in
                return request.identifier == identifier
            }
            completion(isSet)
        }
    }
    
    func setTrainingNotifications(nextTrainingDate: Date) {
        setTommorowTrainingNotification(nextTrainingDate: nextTrainingDate)
        setPreTrainingNotification(nextTrainingDate: nextTrainingDate)
    }
}

private extension NotificationsService {
    struct Constants {
        static let identifierForPreTrainingNotification: String = "preTrainingNotification"
        static let identifierForNextTrainingNotification: String = "tommorowTrainingNotification"
        
        struct timeForPreTrainingNotification {
            static let hour: Int = 10
            static let minut: Int = 0
        }
        
        struct timeForTomorrowTrainingNotification {
            static let hour: Int = 19
            static let minut: Int = 0
        }
    }
}
