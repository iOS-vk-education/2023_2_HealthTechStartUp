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
    func setBodyWeightUnitType(row: Int)
    func setMeasurementsUnitType(row: Int)
    func setLoadWeightUnitType(row: Int)
    func setDistanceUnitType(row: Int)
    func getSelectedBodyWeightCellIndexPath() -> IndexPath
    func getSelectedMeasurementsCellIndexPath() -> IndexPath
    func getSelectedLoadWeightCellIndexPath() -> IndexPath
    func getSelectedDistanceCellIndexPath() -> IndexPath
}

final class SettingsUserDefaultsService: SettingsUserDefaultsServiceDescription {
    public static let shared = SettingsUserDefaultsService()
    
    private init() {}
    
    func setBeginningOfTheWeek(indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        
        switch indexPath {
        case [0, 0]:
            defaults.set(Constants.dateAndTimeKeys[0], forKey: Constants.beginningOfTheWeekKey)
        default:
            defaults.set(Constants.dateAndTimeKeys[1], forKey: Constants.beginningOfTheWeekKey)
        }
    }

    func setTimeFormat(indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        
        switch indexPath {
        case [1, 1]:
            defaults.set(Constants.dateAndTimeKeys[3], forKey: Constants.timeFormat)
        default:
            defaults.set(Constants.dateAndTimeKeys[2], forKey: Constants.timeFormat)
        }
    }

    func getSelectedTimeFormatIndexPath() -> IndexPath {
        let defaults = UserDefaults.standard
        let currentFormat = defaults.string(forKey: Constants.timeFormat)
        
        switch currentFormat {
        case Constants.dateAndTimeKeys[3]:
            return [1, 1]
        default: return [1, 0]
        }
    }

    func getSelectedBeginningOfTheWeekIndexPath() -> IndexPath {
        let defaults = UserDefaults.standard
        let currentFormat = defaults.string(forKey: Constants.beginningOfTheWeekKey)
        
        switch currentFormat {
        case Constants.dateAndTimeKeys[0]:
            return [0, 0]
        default: return [0, 1]
        }
    }
        
    func getSelectedThemeCellIndexPath() -> IndexPath {
        switch self.getSelectedTheme() {
        case "Dark": return [1, 0]
        case "Light": return [1, 1]
        default: return [0, 0]
        }
    }
    
    func getSelectedTheme() -> String? {
        return UserDefaults.standard.string(forKey: Constants.themeKey)
    }

    func setAutoTheme() {
        let defaults = UserDefaults.standard
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
        let defaults = UserDefaults.standard
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
        let defaults = UserDefaults.standard
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
        UserDefaults.standard.set(true, forKey: Constants.switchKeys[1])
    }

    func disabledAutolock(switchState: Bool) {
        UIApplication.shared.isIdleTimerDisabled = true
        UserDefaults.standard.set(switchState, forKey: Constants.switchKeys[1])
    }

    func disableNotifications(switchState: Bool) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UserDefaults.standard.set(switchState, forKey: Constants.switchKeys[0])
    }

    func enableNotifications(switchState: Bool) {
        UIApplication.shared.registerForRemoteNotifications()
        UserDefaults.standard.set(switchState, forKey: Constants.switchKeys[0])
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
        let defaults = UserDefaults.standard
        defaults.set("auto", forKey: Constants.themeKey)
        defaults.set("Monday", forKey: Constants.beginningOfTheWeekKey)
        defaults.set("MilitaryTime", forKey: Constants.timeFormat)
        defaults.set(true, forKey: Constants.switchKeys[0])
        defaults.set(true, forKey: Constants.switchKeys[1])
        defaults.set("email", forKey: Constants.whichSign)
    }
    
    func setBodyWeightUnitType(row: Int) {
        let defaults = UserDefaults.standard
        let key = Constants.bodyWeightKey
        switch row {
        case 0: defaults.set(Constants.kgs, forKey: key)
        case 1: defaults.set(Constants.pounds, forKey: key)
        case 2: defaults.set(Constants.stones, forKey: key)
        default:
            defaults.set(Constants.kgs, forKey: key)
        }
    }
    
    func setMeasurementsUnitType(row: Int) {
        let defaults = UserDefaults.standard
        let key = Constants.measurementsKey
        switch row {
        case 0: defaults.set(Constants.centimeters, forKey: key)
        case 1: defaults.set(Constants.inches, forKey: key)
        default:
            defaults.set(Constants.centimeters, forKey: key)
        }
    }
    
    func setLoadWeightUnitType(row: Int) {
        let defaults = UserDefaults.standard
        let key = Constants.loadWeightKey
        switch row {
        case 0: defaults.set(Constants.kgs, forKey: key)
        case 1: defaults.set(Constants.pounds, forKey: key)
        case 2: defaults.set(Constants.stones, forKey: key)
        default:
            defaults.set(Constants.kgs, forKey: key)
        }
    }
    
    func setDistanceUnitType(row: Int) {
        let defaults = UserDefaults.standard
        let key = Constants.distanceKey
        switch row {
        case 0: defaults.set(Constants.kilometers, forKey: key)
        case 1: defaults.set(Constants.miles, forKey: key)
        default:
            defaults.set(Constants.kilometers, forKey: key)
        }
    }
    
    func getSelectedBodyWeightCellIndexPath() -> IndexPath {
        switch UserDefaults.standard.string(forKey: Constants.bodyWeightKey) {
        case Constants.kgs: return [0, 0]
        case Constants.pounds: return [0, 1]
        case Constants.stones: return [0, 2]
        default:
            return [0, 0]
        }
    }
    
    func getSelectedMeasurementsCellIndexPath() -> IndexPath {
        switch UserDefaults.standard.string(forKey: Constants.measurementsKey) {
        case Constants.centimeters: return [1, 0]
        case Constants.inches: return [1, 1]
        default:
            return [1, 0]
        }
    }
    
    func getSelectedLoadWeightCellIndexPath() -> IndexPath {
        switch UserDefaults.standard.string(forKey: Constants.loadWeightKey) {
        case Constants.kgs: return [2, 0]
        case Constants.pounds: return [2, 1]
        case Constants.stones: return [2, 2]
        default:
            return [2, 0]
        }
    }
    
    func getSelectedDistanceCellIndexPath() -> IndexPath {
        switch UserDefaults.standard.string(forKey: Constants.distanceKey) {
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
