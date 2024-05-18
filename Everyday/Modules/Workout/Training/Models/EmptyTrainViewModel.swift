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
    
    let localizeString: String = "Кажется, пока тут ничего нет.."
    
    init() {
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(NSAttributedString(string: "Кажется, пока тут ничего нет..", attributes: Styles.titleAttributes))
        combinedAttributedString.append(NSAttributedString(string: "\n", attributes: Styles.titleAttributes))
        combinedAttributedString.append(NSAttributedString(string: "Скоро тренировок будет больше".localized, attributes: Styles.titleAttributes))
        
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
