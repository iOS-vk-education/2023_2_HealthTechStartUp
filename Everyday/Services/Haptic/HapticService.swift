//
//  HapticService.swift
//  Everyday
//
//  Created by Михаил on 21.04.2024.
//

import UIKit

protocol HapticServiceDescription {
    func selectionVibrate()
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType)
}

final class HapticService {
    static let shared = HapticService()

    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
