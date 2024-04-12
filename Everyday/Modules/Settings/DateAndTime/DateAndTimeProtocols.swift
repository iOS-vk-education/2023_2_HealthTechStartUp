//
//  DateAndTimeProtocols.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

protocol DateAndTimeModuleInput {
    var moduleOutput: DateAndTimeModuleOutput? { get }
}

protocol DateAndTimeModuleOutput: AnyObject {
}

protocol DateAndTimeViewInput: AnyObject {
}

protocol DateAndTimeViewOutput: AnyObject {
    func didSwipe()
}

protocol DateAndTimeInteractorInput: AnyObject {
}

protocol DateAndTimeInteractorOutput: AnyObject {
}

protocol DateAndTimeRouterInput: AnyObject {
    func getBackToMainView()
}
