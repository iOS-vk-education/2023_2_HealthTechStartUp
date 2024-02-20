import SwiftUI
import UIKit

// MARK: - onBoardingViewController

class OnBoardingViewController: UIHostingController<ContentView> {
    
    // MARK: - properties
    
    var onOnboardingFinished: (() -> Void)?
    
    let standardAppearance = UINavigationBarAppearance()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
         super.viewDidLoad()
       
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - init
        
    init(onFinish: @escaping () -> Void) {
        let contentView = ContentView(onFinish: onFinish)
        super.init(rootView: contentView)
    }
    
    // MARK: - actions
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
