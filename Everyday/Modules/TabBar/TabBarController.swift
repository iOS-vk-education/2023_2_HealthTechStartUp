//
//  TabBarController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//

import UIKit
import FirebaseAuth

// MARK: - TabBarController

final class TabBarController: UITabBarController {
    private var isUserAuthenticated: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        delegate = self
    }
    
    // MARK: - Actions
    
    private func setupTabBar() {
        let navigationControllers = TabBarItem.allCases.map { createNavigationController(for: $0) }
        setViewControllers(navigationControllers, animated: false)
    }

    private func createNavigationController(for item: TabBarItem) -> UINavigationController {
        let viewController: UIViewController
        let tabBarItem = UITabBarItem()

        switch item {
        case .notepad:
            viewController = NotepadContainer.assemble(with: .init()).viewController
            tabBarItem.title = "Notepad_title".localized
        case .progress:
            viewController = ProgressContainer.assemble(with: .init()).viewController
            tabBarItem.title = "Progress_title".localized
        case .workout:
            viewController = WorkoutContainer.assemble(with: .init()).viewController
            tabBarItem.title = "Workout_title".localized
        case .settings:
            viewController = SettingsContainer.assemble(with: .init()).viewController
            tabBarItem.title = "Settings_title".localized
        }

        tabBarItem.tag = item.rawValue
        viewController.tabBarItem = tabBarItem

        return UINavigationController(rootViewController: viewController)
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        isUserAuthenticated = checkAuthentication()
        
        let selectedItem = TabBarItem(rawValue: selectedIndex)
        
        switch selectedItem {
        case .notepad, .progress:
            if isUserAuthenticated {
                return true
            } else {
               offerAuthentication()
                return false
            }
        default:
            return true
        }
    }
    
    // MARK: - Helpers
    
    private func checkAuthentication() -> Bool {
        let coreDataService = CoreDataService.shared
        
        guard let authTypes = coreDataService.getAllItems() else {
            return false
        }
               
        guard !authTypes.isEmpty else {
           return false
        }
        
        if !UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
            return false
        }
        
        return true
    }
    
    private func offerAuthentication() {
        guard (viewControllers?.first(where: { $0 is WorkoutViewController })) != nil else {
            return
        }
        
        let authScreen = AuthorizationContainer.assemble(with: .init()).viewController
        let navigationController = UINavigationController(rootViewController: authScreen)
        navigationController.navigationBar.isHidden = true
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .init("small"), resolver: { _ in
                    return self.view.frame.height / 3.5
                })
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = false
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        
        present(navigationController, animated: true)
    }
}

// MARK: - Helpers

enum TabBarItem: Int, CaseIterable {
    case notepad
    case progress
    case workout
    case settings
}
