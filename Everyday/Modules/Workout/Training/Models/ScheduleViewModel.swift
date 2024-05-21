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
        self.title = NSAttributedString(string: "ScheduleViewModel_title".localized, attributes: Styles.titleAttributes)
        
        self.schedule = [NSAttributedString(string: "TrainViewController_mo".localized, attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "TrainViewController_tu".localized, attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "TrainViewController_we".localized, attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "TrainViewController_th".localized, attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "TrainViewController_fr".localized, attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "TrainViewController_sa".localized, attributes: Styles.scheduleAttributes),
                         NSAttributedString(string: "TrainViewController_su".localized, attributes: Styles.scheduleAttributes)
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
