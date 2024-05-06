//
//  SettingsInteractor.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import UIKit

final class SettingsInteractor {
    weak var output: SettingsInteractorOutput?
    
    private func setLink(_ type: FeedBack, _ appURL: inout String, _ webURL: inout String) {
        switch type {
        case .problem:
            appURL += "4"
            webURL += "4"
        case .privacy:
            appURL = "https://www.termsfeed.com/live/f9193207-2fe9-41c0-bcd6-0e2c2640e94c"
            webURL = "https://www.termsfeed.com/live/f9193207-2fe9-41c0-bcd6-0e2c2640e94c"
        case .suggest:
            appURL += "3"
            webURL += "3"
        }
    }
}

extension SettingsInteractor: SettingsInteractorInput {
    func openURL(with type: FeedBack) {
        var appURL = "tg://resolve?domain=everydayheal&start="
        var webURL = "https://t.me/everydayheal/"
        
        setLink(type, &appURL, &webURL)
        
        guard let appURL = URL(string: appURL),
              let webURL = URL(string: webURL)
        else {
            output?.didFailOpenURL()
            return
        }
        output?.didOpenURL(with: appURL, and: webURL)
    }
}
