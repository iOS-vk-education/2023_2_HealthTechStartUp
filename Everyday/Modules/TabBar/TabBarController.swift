//
//
//  Created by Михаил on 16.02.2024.
//

import SwiftUI
import FirebaseAuth

// MARK: - TabBarController

final class TabBarController: UITabBarController {
    private var isUserAuthenticated: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        selectedIndex = 2
        tabBar.tintColor = Constants.accentColor
        tabBar.isTranslucent = false
        tabBar.backgroundColor = Constants.background
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = Constants.background
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        UINavigationBar.appearance().barTintColor = Constants.background
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Actions

    private func setupTabBar() {
        let navigationControllers = TabBarItem.allCases.map { createNavigationController(for: $0) }
        self.setViewControllers(navigationControllers, animated: false)
    }
    
    private func createNavigationController(for item: TabBarItem) -> UINavigationController {
        let viewController: UIViewController
        
        let tabBarItem = UITabBarItem(title: item.title, image: item.image, tag: item.rawValue)
        
        switch item {
        case .notepad:
            viewController = NotepadContainer.assemble(with: .init()).viewController
        case .progress:
            viewController = UIHostingController(rootView: ResultsView())
        case .workout:
            viewController = WorkoutContainer.assemble(with: .init()).viewController
            tabBarItem.title = Constants.Workout.title
            tabBarItem.image = UIImage(named: Constants.Workout.image)
        case .settings:
            viewController = SettingsContainer.assemble(with: .init()).viewController
        }

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
        
        isUserAuthenticated = Reloader.shared.checkAuthentication()
        
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
    
    private func offerAuthentication() {
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

enum TabBarItem: Int, CaseIterable {
    case notepad
    case progress
    case workout
    case settings
    
    var title: String {
        switch self {
        case .notepad: return Constants.Notepad.title
        case .progress: return Constants.Progress.title
        case .settings: return Constants.Settings.title
        default: return ""
        }
    }
    
    var image: UIImage? {
        switch self {
        case .notepad: return UIImage(systemName: Constants.Notepad.image)
        case .progress: return UIImage(systemName: Constants.Progress.image)
        case .settings: return UIImage(systemName: Constants.Settings.image)
        default: return UIImage()
        }
    }
    
    struct Constants {
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

private extension TabBarController {
    struct Constants {
        static let accentColor: UIColor = UIColor.UI.accent
        static let background: UIColor = UIColor.background

        struct Workout {
            static let title: String = "Workout_title".localized
            static let image: String = "glass"
        }
    }
}
