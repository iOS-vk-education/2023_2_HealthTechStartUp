//
//  CatalogViewModel.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import UIKit

struct CatalogViewModel {
    let title: NSAttributedString
    
    init(title: String) {
        self.title = NSAttributedString(string: title, attributes: Styles.titleAttributes)
    }
}

extension CatalogViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 26)
        ]
    }
}
