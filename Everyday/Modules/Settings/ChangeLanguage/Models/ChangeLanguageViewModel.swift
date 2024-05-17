//
//  ChangeLanguageViewModel.swift
//  Everyday
//
//  Created by Yaz on 05.05.2024.
//

import Foundation
import UIKit

struct ChangeLanguageViewModel {
    let changeLanguageTitle: NSAttributedString
    let englishTitle: NSAttributedString
    let russianTitle: NSAttributedString
    let languages: [NSAttributedString]
    let accessoryCellImage: UIImage?
    
    let interfaceLanguageHeaderTitle: String
    let descriptionOfChanges: String
    
    init() {
        self.changeLanguageTitle = NSAttributedString(string: "ChangeLanguage_title".localized, attributes: Styles.titleAttributesBold)
        self.englishTitle = NSAttributedString(string: "ChangeLanguage_En_title".localized, attributes: Styles.titleAttributes)
        self.russianTitle = NSAttributedString(string: "ChangeLanguage_Ru_title".localized, attributes: Styles.titleAttributes)
        self.languages = [englishTitle, russianTitle]
        self.accessoryCellImage = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysOriginal)
        
        self.interfaceLanguageHeaderTitle = "ChangeLanguage_InterfaceLanguage_title".localized
        self.descriptionOfChanges = "ChangeLanguage_DescriptionOfChanges_title".localized
    }
}

private extension ChangeLanguageViewModel {
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
