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
    func configure(with: DateAndTimeViewModel)
}

protocol DateAndTimeViewOutput: AnyObject {
    func getSelectedBegginingOfTheWeekCellIndexPath() -> IndexPath
    func getSelectedTimeFormatCellIndexPath() -> IndexPath
    func didTapOnCellInBegginingOfTheWeekSection(indexPath: IndexPath)
    func didTapOnCellInTimeFormatSection(indexPath: IndexPath)
    func didLoadView()
    func getDateAndTimeViewModel() -> DateAndTimeViewModel
    func didSwipe()
}

protocol DateAndTimeRouterInput: AnyObject {
    func getBackToMainView()
}
