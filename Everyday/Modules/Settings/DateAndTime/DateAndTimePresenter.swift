//
//  DateAndTimePresenter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

final class DateAndTimePresenter {
    weak var view: DateAndTimeViewInput?
    weak var moduleOutput: DateAndTimeModuleOutput?
    
    private let router: DateAndTimeRouterInput
    private let settingsUserDefaultsService: SettingsUserDefaultsService = SettingsUserDefaultsService.shared
    
    init(router: DateAndTimeRouterInput) {
        self.router = router
    }
}

extension DateAndTimePresenter: DateAndTimeModuleInput {
}

extension DateAndTimePresenter: DateAndTimeViewOutput {
    func getSelectedBegginingOfTheWeekCellIndexPath() -> IndexPath {
        settingsUserDefaultsService.getSelectedBeginningOfTheWeekIndexPath()
    }
    
    func getSelectedTimeFormatCellIndexPath() -> IndexPath {
        settingsUserDefaultsService.getSelectedTimeFormatIndexPath()
    }
    
    func didTapOnCellInBegginingOfTheWeekSection(indexPath: IndexPath) {
        settingsUserDefaultsService.setBeginningOfTheWeek(indexPath: indexPath)
    }
    
    func didTapOnCellInTimeFormatSection(indexPath: IndexPath) {
        settingsUserDefaultsService.setTimeFormat(indexPath: indexPath)
    }
    
    func didLoadView() {
        let model = DateAndTimeViewModel()
        view?.configure(with: model)
    }
    
    func getDateAndTimeViewModel() -> DateAndTimeViewModel {
        let model = DateAndTimeViewModel()
        return model
    }
    
    func didSwipe() {
        router.getBackToMainView()
    }
}
