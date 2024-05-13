import SwiftUI
import UIKit

// MARK: - onBoardingViewController

class OnBoardingViewController: UIHostingController<ContentView> {
    
    // MARK: - properties
    
    let standardAppearance = UINavigationBarAppearance()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
         super.viewDidLoad()
       
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - init
        
    init(authType: String, onFinish: @escaping () -> Void) {
        let contentView = ContentView(authType: authType, onFinish: onFinish)
        super.init(rootView: contentView)
    }
    
    // MARK: - actions
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
