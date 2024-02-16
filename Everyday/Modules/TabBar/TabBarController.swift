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
                tabBarItem.title = "notepad_title".localized
            case .progress:
                viewController = ProgressContainer.assemble(with: .init()).viewController
                tabBarItem.title = "progress_title".localized
            case .workout:
                viewController = WorkoutContainer.assemble(with: .init()).viewController
                tabBarItem.title = "workout_title".localized
            case .settings:
                viewController = SettingsContainer.assemble(with: .init()).viewController
                tabBarItem.title = "settings_title".localized
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
