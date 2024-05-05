//
//  HealthViewModel.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//

import Foundation
import UIKit

struct HealthViewModel {
    let healthTitle: NSAttributedString
    let connectedTitle: NSAttributedString
    let connectedImage: UIImage?
    let notConnectedImage: UIImage?
    let discriptionForConnectedTitle: NSAttributedString
    let reloadWorkoutsTitle: NSAttributedString
    let reloadMeasureTitle: NSAttributedString
    let cellsTitlesInSecondSection: [NSAttributedString]
    init() {
        self.healthTitle = NSAttributedString(string: "Health_title", attributes: Styles.titleAttributesBold)
        self.connectedTitle = NSAttributedString(string: "Health_Connected_title".localized)
        self.reloadWorkoutsTitle = NSAttributedString(string: "Health_Reloadworkouts_title".localized)
        self.reloadMeasureTitle = NSAttributedString(string: "Health_ReloadMeasure_title".localized)
        self.notConnectedImage = UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal)
        self.connectedImage = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysOriginal)
        self.discriptionForConnectedTitle = NSAttributedString(string: "Health_DiscriptionForConnected_title".localized)
        self.cellsTitlesInSecondSection = [reloadWorkoutsTitle, reloadMeasureTitle]
    }
}

private extension HealthViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let titleAttributesBold: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
    }
}
