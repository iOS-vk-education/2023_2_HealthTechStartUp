//
//  UserDefaultsServiceForSettings.swift
//  Everyday
//
//  Created by Yaz on 21.03.2024.
//

import UIKit

protocol SettingsUserDefaultsServiceDescription {
    func setBeginningOfTheWeek(indexPath: IndexPath)
    func setTimeFormat(indexPath: IndexPath)
    func getSelectedTimeFormatIndexPath() -> IndexPath
    func getSelectedBeginningOfTheWeekIndexPath() -> IndexPath
    func getSelectedThemeCellIndexPath() -> IndexPath
    func getSelectedTheme() -> String?
    func setDarkTheme()
    func setLightTheme()
    func setTheme()
    func enableAutolock(switchState: Bool)
    func disabledAutolock(switchState: Bool)
    func disableNotifications(switchState: Bool)
    func enableNotifications(switchState: Bool)
    func saveSwitchValue(switchState: Bool, key: Int)
    func switchIsOn(key: Int) -> Bool
    func resetUserDefaults()
    func setUserName(username: String)
    func getUserName() -> String
    func setBodyWeightUnitType(measureUnit: String)
    func setMeasurementsUnitType(measureUnit: String)
    func setLoadWeightUnitType(measureUnit: String)
    func setDistanceUnitType(measureUnit: String)
    func getSelectedBodyWeightCellIndexPath() -> IndexPath
    func getSelectedMeasurementsCellIndexPath() -> IndexPath
    func getSelectedLoadWeightCellIndexPath() -> IndexPath
    func getSelectedDistanceCellIndexPath() -> IndexPath
}

final class SettingsUserDefaultsService: SettingsUserDefaultsServiceDescription {
    public static let shared = SettingsUserDefaultsService()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func setBeginningOfTheWeek(indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            defaults.set(Constants.dateAndTimeKeys[0], forKey: Constants.beginningOfTheWeekKey)
        default:
            defaults.set(Constants.dateAndTimeKeys[1], forKey: Constants.beginningOfTheWeekKey)
        }
    }

    func setTimeFormat(indexPath: IndexPath) {
        switch indexPath {
        case [1, 1]:
            defaults.set(Constants.dateAndTimeKeys[3], forKey: Constants.timeFormat)
        default:
            defaults.set(Constants.dateAndTimeKeys[2], forKey: Constants.timeFormat)
        }
    }

    func getSelectedTimeFormatIndexPath() -> IndexPath {
        let currentFormat = defaults.string(forKey: Constants.timeFormat)
        
        switch currentFormat {
        case Constants.dateAndTimeKeys[3]:
            return [1, 1]
        default: return [1, 0]
        }
    }

    func getSelectedBeginningOfTheWeekIndexPath() -> IndexPath {
        let currentFormat = defaults.string(forKey: Constants.beginningOfTheWeekKey)
        
        switch currentFormat {
        case Constants.dateAndTimeKeys[0]:
            return [0, 0]
        default: return [0, 1]
        }
    }
        
    func getSelectedThemeCellIndexPath() -> IndexPath {
        switch self.getSelectedTheme() {
        case "dark": return [1, 0]
        case "light": return [1, 1]
        default: return [0, 0]
        }
    }
    
    func getSelectedTheme() -> String? {
        return defaults.string(forKey: Constants.themeKey)
    }

    func setAutoTheme() {
        defaults.set(Constants.themeKeys[0], forKey: Constants.themeKey)
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.overrideUserInterfaceStyle = .unspecified
                    }, completion: nil)
                }
            }
        }
    }

    func setDarkTheme() {
        defaults.set(Constants.themeKeys[1], forKey: Constants.themeKey)
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.overrideUserInterfaceStyle = .dark
                    }, completion: nil)
                }
            }
        }
    }

    func setLightTheme() {
        defaults.set(Constants.themeKeys[2], forKey: Constants.themeKey)
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.overrideUserInterfaceStyle = .light
                    }, completion: nil)
                }
            }
        }
    }
    
    func setTheme() {
        switch getSelectedTheme() {
        case Constants.themeKeys[1]: setDarkTheme()
        case Constants.themeKeys[2]: setLightTheme()
        default: setAutoTheme()
        }
    }

    func enableAutolock(switchState: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
        defaults.set(true, forKey: Constants.switchKeys[1])
    }

    func disabledAutolock(switchState: Bool) {
        UIApplication.shared.isIdleTimerDisabled = true
        defaults.set(switchState, forKey: Constants.switchKeys[1])
    }

    func disableNotifications(switchState: Bool) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        defaults.set(switchState, forKey: Constants.switchKeys[0])
    }

    func enableNotifications(switchState: Bool) {
        UIApplication.shared.registerForRemoteNotifications()
        defaults.set(switchState, forKey: Constants.switchKeys[0])
    }

    func saveSwitchValue(switchState: Bool, key: Int ) {
        let switchKey = Constants.switchKeys[key]
        switch switchKey {
        case Constants.switchKeys[0]:
            if switchState {
                enableNotifications(switchState: switchState)
            } else {
                disableNotifications(switchState: switchState)
            }
        case Constants.switchKeys[1]:
            if switchState {
                enableAutolock(switchState: switchState)
            } else {
                disabledAutolock(switchState: switchState)
            }
        default:
            print(switchState, key)
        }
    }

    func switchIsOn(key: Int) -> Bool {
        UserDefaults.standard.bool(forKey: Constants.switchKeys[key])
    }
    
    func setUserName(username: String) {
        UserDefaults.standard.set(username, forKey: Constants.userNameKey)
    }
    
    func getUserName() -> String {
        guard let userName = UserDefaults.standard.string(forKey: Constants.userNameKey) else {
            return ""
        }
        return userName
    }

    func resetUserDefaults() {
        defaults.set("auto", forKey: Constants.themeKey)
        defaults.set("Monday", forKey: Constants.beginningOfTheWeekKey)
        defaults.set("MilitaryTime", forKey: Constants.timeFormat)
        defaults.set(true, forKey: Constants.switchKeys[0])
        defaults.set(true, forKey: Constants.switchKeys[1])
        defaults.set("email", forKey: Constants.whichSign)
    }
    
    func setBodyWeightUnitType(measureUnit: String) {
        let key = Constants.bodyWeightKey
        
        defaults.set(measureUnit, forKey: key)
    }
    
    func setMeasurementsUnitType(measureUnit: String) {
        let key = Constants.measurementsKey
        
        defaults.set(measureUnit, forKey: key)
    }
    
    func setLoadWeightUnitType(measureUnit: String) {
        let key = Constants.loadWeightKey
        
        defaults.set(measureUnit, forKey: key)
    }
    
    func setDistanceUnitType(measureUnit: String) {
        let key = Constants.distanceKey
        
        defaults.set(measureUnit, forKey: key)
    }
    
    func getSelectedBodyWeightCellIndexPath() -> IndexPath {
        switch defaults.string(forKey: Constants.bodyWeightKey) {
        case Constants.kgs: return [0, 0]
        case Constants.pounds: return [0, 1]
        case Constants.stones: return [0, 2]
        default:
            return [0, 0]
        }
    }
    
    func getSelectedMeasurementsCellIndexPath() -> IndexPath {
        switch defaults.string(forKey: Constants.measurementsKey) {
        case Constants.centimeters: return [1, 0]
        case Constants.inches: return [1, 1]
        default:
            return [1, 0]
        }
    }
    
    func getSelectedLoadWeightCellIndexPath() -> IndexPath {
        switch defaults.string(forKey: Constants.loadWeightKey) {
        case Constants.kgs: return [2, 0]
        case Constants.pounds: return [2, 1]
        case Constants.stones: return [2, 2]
        default:
            return [2, 0]
        }
    }
    
    func getSelectedDistanceCellIndexPath() -> IndexPath {
        switch defaults.string(forKey: Constants.distanceKey) {
        case Constants.kilometers: return [3, 0]
        case Constants.miles: return [3, 1]
        default:
            return [3, 0]
        }
    }
}

private extension SettingsUserDefaultsService {
    struct Constants {
        static let bodyWeightKey = "bodyWeightMeasureUnit"
        static let measurementsKey = "measurementsMeasureUnit"
        static let loadWeightKey = "loadWeightMeasureUnit"
        static let distanceKey = "distanceMeasureUnit"
        static let kgs = "kg"
        static let pounds = "lb"
        static let stones = "st"
        static let centimeters = "centimeters"
        static let inches = "inches"
        static let kilometers = "kilometers"
        static let miles = "miles"
        
        static let whichSign = "WhichSign"
        static let userNameKey = "username"
        static let themeKey = "selectedTheme"
        static let beginningOfTheWeekKey = "beginningOfTheWeek"
        static let timeFormat = "timeFormat"
        static let themeKeys = ["auto", "dark", "light"]
        static let switchKeys = ["soundSwitchIsEnabled", "autolockSwitchIsEnabled"]
        static let dateAndTimeKeys = ["Sunday", "Monday", "MilitaryTime", "AM/PM"]
    }
}
