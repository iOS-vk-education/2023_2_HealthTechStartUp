//
//  UnitsViewModel.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//

import UIKit

struct UnitsViewModel {
    let unitsTitle: NSAttributedString
    let bodyWeigthTitle: NSAttributedString
    let kgmsTitle: NSAttributedString
    let poundsTitle: NSAttributedString
    let measurementsTitle: NSAttributedString
    let cmsTitle: NSAttributedString
    let inchesTitle: NSAttributedString
    let weightTitle: NSAttributedString
    let distanceTitle: NSAttributedString
    let klmsTitle: NSAttributedString
    let milesTitle: NSAttributedString
    let aboutUnitsTitle: NSAttributedString
    let weightSectionModel: [NSAttributedString]
    let measurementsSectionModel: [NSAttributedString]
    let distanceSectionModel: [NSAttributedString]
    
    init() {
        self.unitsTitle = NSAttributedString(string: "Units_title".localized, attributes: Styles.titleAttributesBold)
        self.bodyWeigthTitle = NSAttributedString(string: "Units_BodyWeight_title".localized, attributes: Styles.titleAttributes)
        self.kgmsTitle = NSAttributedString(string: "Units_Kilograms_title".localized, attributes: Styles.titleAttributes)
        self.poundsTitle = NSAttributedString(string: "Units_Pounds_title".localized, attributes: Styles.titleAttributes)
        self.measurementsTitle = NSAttributedString(string: "Units_Measurements_title".localized, attributes: Styles.titleAttributes)
        self.cmsTitle = NSAttributedString(string: "Units_Centimeters_title".localized, attributes: Styles.titleAttributes)
        self.inchesTitle = NSAttributedString(string: "Units_Inches_title".localized, attributes: Styles.titleAttributes)
        self.weightTitle = NSAttributedString(string: "Units_Weight_title".localized, attributes: Styles.titleAttributes)
        self.distanceTitle = NSAttributedString(string: "Units_Distance_title".localized, attributes: Styles.titleAttributes)
        self.klmsTitle = NSAttributedString(string: "Units_Kilometers_title".localized, attributes: Styles.titleAttributes)
        self.milesTitle = NSAttributedString(string: "Units_Miles_title".localized, attributes: Styles.titleAttributes)
        self.aboutUnitsTitle = NSAttributedString(string: "Units_AboutUnits_title".localized, attributes: Styles.titleAttributes)
        self.weightSectionModel = [kgmsTitle, poundsTitle]
        self.measurementsSectionModel = [cmsTitle, inchesTitle]
        self.distanceSectionModel = [klmsTitle, milesTitle]
    }
}

private extension UnitsViewModel {
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
