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
    private var isAuthenticationCheckInProgress: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        selectedIndex = 2
        delegate = self
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

        return viewController
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        let selectedItem = TabBarItem(rawValue: selectedIndex)
        
        switch selectedItem {
        case .notepad, .progress:
            if isAuthenticationCheckInProgress {
                return false
            }
            isAuthenticationCheckInProgress = true
            checkAuthentication(for: viewController)
            
            return false
        default:
            return true
        }
    }
    
    private func checkAuthentication(for viewController: UIViewController) {
        guard Auth.auth().currentUser == nil else {
            return
        }
        
        guard (viewControllers?.first(where: { $0 is WorkoutViewController })) != nil else {
            return
        }
        
        let welcomeScreen = WelcomeScreenContainer.assemble(with: .init()).viewController
        
//        if let sheet = welcomeScreen.sheetPresentationController {
//            sheet.detents = [.medium()]
//            sheet.preferredCornerRadius = 20
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//            sheet.largestUndimmedDetentIdentifier = .medium
//            sheet.prefersEdgeAttachedInCompactHeight = true
//        }
        
        welcomeScreen.modalPresentationStyle = .custom
        welcomeScreen.transitioningDelegate = self
        
       present(welcomeScreen, animated: true) { [weak self] in
           self?.isAuthenticationCheckInProgress = false
       }
    }
}

// MARK: - Helpers

enum TabBarItem: Int, CaseIterable {
    case notepad
    case progress
    case workout
    case settings
}

extension TabBarController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, 
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        HalfScreenViewController(presentedViewController: presented, presenting: presenting)
    }
}
