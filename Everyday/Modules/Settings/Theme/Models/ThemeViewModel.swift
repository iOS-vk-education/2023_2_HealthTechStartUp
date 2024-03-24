//
//  ThemeViewModel.swift
//  Everyday
//
//  Created by Yaz on 09.03.2024.
//

import UIKit

struct ThemeViewModel {
    let themeTitle: NSAttributedString
    let autoThemeTitle: NSAttributedString
    let darkTitle: NSAttributedString
    let lightTitle: NSAttributedString
    let explanationForAutoTheme: NSAttributedString
    let darkOrLightSectionSellModel: [NSAttributedString]
    let accessoryCellImage: UIImage?
    
    init() {
        self.themeTitle = NSAttributedString(string: "Theme_title".localized, attributes: Styles.titleAttributesBold)
        self.autoThemeTitle = NSAttributedString(string: "Theme_AutoTheme_title".localized, attributes: Styles.titleAttributes)
        self.darkTitle = NSAttributedString(string: "Theme_DarkTheme_title".localized, attributes: Styles.titleAttributes)
        self.lightTitle = NSAttributedString(string: "Theme_LightTheme_title".localized, attributes: Styles.titleAttributes)
        self.explanationForAutoTheme = NSAttributedString(string: "Theme_DescriptionForAutoTheme_title".localized, attributes: Styles.titleAttributes)
        self.darkOrLightSectionSellModel = [darkTitle, lightTitle]
        self.accessoryCellImage = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysOriginal)
    }
}

private extension ThemeViewModel {
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
