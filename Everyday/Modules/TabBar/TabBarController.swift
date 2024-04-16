//
//  TabBarController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//

import UIKit

// MARK: - TabBarController

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = Constants.accentColor
        setupTabBar()
        selectedIndex = 1
    }
    
    // MARK: - actions
    
    private func setupTabBar() {
            let viewControllers = TabBarItem.allCases.map { createViewController(for: $0) }
            self.setViewControllers(viewControllers, animated: false)
        }

        private func createViewController(for item: TabBarItem) -> UIViewController {
            let viewController: UIViewController
            let tabBarItem = UITabBarItem()

            switch item {
            case .notepad:
                viewController = NotepadContainer.assemble(with: .init()).viewController
                tabBarItem.title = Constants.Notepad.title
                tabBarItem.image = UIImage(systemName: Constants.Notepad.image)
            case .progress:
                viewController = ProgressContainer.assemble(with: .init()).viewController
                tabBarItem.title = Constants.Progress.title
                tabBarItem.image = UIImage(systemName: Constants.Progress.image)
            case .workout:
                viewController = WorkoutContainer.assemble(with: .init()).viewController
                tabBarItem.title = Constants.Workout.title
                tabBarItem.image = UIImage(named: Constants.Workout.image)
            case .settings:
                viewController = SettingsContainer.assemble(with: .init()).viewController
                tabBarItem.title = Constants.Settings.title
                tabBarItem.image = UIImage(systemName: Constants.Settings.image)
            }

            tabBarItem.tag = item.rawValue
            viewController.tabBarItem = tabBarItem

            return viewController
        }
}

// MARK: - Helpers

enum TabBarItem: Int, CaseIterable {
    case notepad
    case progress
    case workout
    case settings
}

private extension TabBarController {
    struct Constants {
        static let accentColor: UIColor = UIColor.UI.accent
        
        struct Notepad {
            static let title: String = "Notepad_title".localized
            static let image: String = "dumbbell"
        }
        
        struct Progress {
            static let title: String = "Progress_title".localized
            static let image: String = "doc.plaintext"
        }
        
        struct Workout {
            static let title: String = "Workout_title".localized
            static let image: String = "glass"
        }
        
        struct Settings {
            static let title: String = "Settings_title".localized
            static let image: String = "gear"
        }
    }
}
