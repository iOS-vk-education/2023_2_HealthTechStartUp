//
//  OnBoardingModel.swift
//  welcome
//
//  Created by Михаил on 12.02.2024.
//

import SwiftUI

final class PageViewModel: ObservableObject {
    var page: Page
    let next: NSAttributedString
    let skip: NSAttributedString

    init(page: Page) {
        self.page = page
        self.next = NSAttributedString(string: "Onboarding_next_button_title".localized, attributes: Styles.buttonAttributes)
        self.skip = NSAttributedString(string: "Onboarding_skip_button_title".localized, attributes: Styles.buttonAttributes)
    }
}

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: NSAttributedString
    var description: NSAttributedString
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(name: NSAttributedString(string: "debug", attributes: Styles.titleAttributes),
                                 description: NSAttributedString(string: "sample description", attributes: Styles.titleAttributes),
                                 imageUrl: "firstWindow",
                                 tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: NSAttributedString(string: "Onboarding_Introduction_page1_title".localized, attributes: Styles.titleAttributes),
             description: NSAttributedString(string: "Onboarding_Introduction_page1_description".localized, attributes: Styles.descriptionAttributes),
             imageUrl: "firstWindow", tag: 0),
        Page(name: NSAttributedString(string: "Onboarding_Introduction_page2_title".localized, attributes: Styles.titleAttributes),
             description: NSAttributedString(string: "Onboarding_Introduction_page2_description".localized, attributes: Styles.descriptionAttributes),
             imageUrl: "secondWindow", tag: 1),
        Page(name: NSAttributedString(string: "Onboarding_Introduction_page3_title".localized, attributes: Styles.titleAttributes),
             description: NSAttributedString(
                string: "Onboarding_Introduction_page3_description".localized, attributes: Styles.descriptionAttributes),
                imageUrl: "thirdWindow",
                tag: 2
             )
    ]
}

private extension Page {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 26)
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}

private extension PageViewModel {
    struct Styles {
        static let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}
