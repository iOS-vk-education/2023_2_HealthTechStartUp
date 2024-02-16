//
//  AgeViewModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

struct AgeViewModel {
    let title: NSAttributedString
    let next: NSAttributedString
    let skip: NSAttributedString
    
    init() {
        self.title = NSAttributedString(string: "onboard5_title".localized, attributes: Styles.titleAttributes)
        self.next = NSAttributedString(string: "next".localized, attributes: Styles.buttonAttributes)
        self.skip = NSAttributedString(string: "skip".localized, attributes: Styles.buttonAttributes)
    }
}

extension AgeViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 26)
        ]
        
        static let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
    
    func ageText(for age: Age) -> String {
        switch age {
        case .small: return "17 - 24"
        case .young: return "25 - 34"
        case .adult: return "35 - 54"
        case .old: return "55+"
        }
    }
    
    func ageAttributedText(for age: Age) -> NSAttributedString {
        let text = ageText(for: age)
        return NSAttributedString(string: text, attributes: AgeViewModel.Styles.buttonAttributes)
    }
}
