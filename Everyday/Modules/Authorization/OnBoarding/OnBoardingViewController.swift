import SwiftUI
import UIKit

class onBoardingViewController: UIHostingController<ContentView> {
    init() {
        super.init(rootView: ContentView())
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
