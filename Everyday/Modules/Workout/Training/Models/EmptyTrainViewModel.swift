//
//  EmptyTrainViewModel.swift
//  Everyday
//
//  Created by Михаил on 14.05.2024.
//

import UIKit

struct EmptyTrainViewModel {
    let imageTitle: String
    let labelTitle: NSAttributedString
    
    init() {
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(NSAttributedString(string: "EmptyTrainViewModel1".localized, attributes: Styles.titleAttributes))
        combinedAttributedString.append(NSAttributedString(string: "\n", attributes: Styles.titleAttributes))
        combinedAttributedString.append(NSAttributedString(string: "EmptyTrainViewModel2".localized, attributes: Styles.titleAttributes))
        
        self.labelTitle = combinedAttributedString
        self.imageTitle = "pleaseWait"
    }
}

extension EmptyTrainViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "SpaceGray") ?? .black,
            .font: UIFont(name: "Arial-Black", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        ]
    }
}
