//
//  UserDefaultsServiceForSettings.swift
//  Everyday
//
//  Created by Yaz on 21.03.2024.
//

import UIKit

private let themeKeys = ["Auto", "Dark", "Light"]

private let switchKeys = ["soundSwitch", "autolockSwitch"]
private let notificationsKeys = ["notificationsEnabled", "notificationsDisabled"]
private let autolockKeys = ["autolockEnabled", "autolockDisabled"]

func getSelectedTheme() -> String? {
    return UserDefaults.standard.string(forKey: "SelectedTheme")
}

func setAutoTheme() {
    let defaults = UserDefaults.standard
    defaults.set(themeKeys[0], forKey: "SelectedTheme")
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
    defaults.set(themeKeys[1], forKey: "SelectedTheme")
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
    defaults.set(themeKeys[2], forKey: "SelectedTheme")
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
    case "Dark": setDarkTheme()
    case "Light": setLightTheme()
    default: setAutoTheme()
    }
}

func enableAutolock() {
    UIApplication.shared.isIdleTimerDisabled = false
    UserDefaults.standard.set(true, forKey: notificationsKeys[0])
}

func disabledAutolock() {
    UIApplication.shared.isIdleTimerDisabled = true
    UserDefaults.standard.set(false, forKey: notificationsKeys[0])
}

func disableNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UserDefaults.standard.set(false, forKey: notificationsKeys[1])
}

func enableNotifications() {
    UIApplication.shared.registerForRemoteNotifications()
    UserDefaults.standard.set(true, forKey: notificationsKeys[0])
}

func saveSwitchValue(switchState: Bool, key: Int ) {
    
    let switchKey = switchKeys[key]
    
    if switchKey == switchKeys[0] && switchState {
        enableNotifications()
    } else {
        disableNotifications()
    }
    
    if switchKey == switchKeys[1] && switchState {
        enableAutolock()
    } else {
        disabledAutolock()
    }
    
    UserDefaults.standard.set(switchState, forKey: switchKey)
}

func switchIsOn(key: Int) -> Bool {
    UserDefaults.standard.bool(forKey: switchKeys[key])
}
