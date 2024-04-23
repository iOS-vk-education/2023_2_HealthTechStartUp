//
//  WelcomeScreenViewController.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//
//

import UIKit
import PinLayout

final class WelcomeScreenViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: WelcomeScreenViewOutput
    private let signUpButton = UIButton(type: .system)
    private let signInButton = UIButton(type: .system)
    private let triangleView = UIView()
    private let controllersScrollView: UIScrollView = UIScrollView()

    private var signInViewController: UIViewController?
    private var signUpViewController: UIViewController?
    private var activePage: ActivePage = .signUp
    
    // MARK: - Init
    
    init(output: WelcomeScreenViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        output.didLoadView()
        output.getSignUp()
        output.getSignIn()
        setupUI()
        
        view.addSubviews(controllersScrollView, signUpButton, signInButton, triangleView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWholeView))
                view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            let newFillColor: CGColor = Constants.accentLight.cgColor
            
            if let shapeLayer = triangleView.layer.sublayers?.first(where: { $0 is CAShapeLayer }) as? CAShapeLayer {
                shapeLayer.fillColor = newFillColor
            }
        }
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        setupButtons()
        setupScrollView()
        setupTriangleIndicator()
    }
    
    private func setupButtons() {
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    private func setupScrollView() {
        guard let signIn = signInViewController, let signUp = signUpViewController else {
            return
        }
        
        controllersScrollView.bounces = false
        controllersScrollView.layer.cornerRadius = Constants.ScrollView.cornerRadius
        controllersScrollView.layer.masksToBounds = true
        controllersScrollView.contentSize.width = signIn.view.frame.width + signUp.view.frame.width
        controllersScrollView.showsVerticalScrollIndicator = false
        controllersScrollView.showsHorizontalScrollIndicator = false
        controllersScrollView.delegate = self
        controllersScrollView.isPagingEnabled = true
        
        controllersScrollView.addSubviews(signUp.view, signIn.view)
    }
    
    private func setupTriangleIndicator() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: Constants.Triangle.size.width / 2, y: 0))
        path.addLine(to: CGPoint(x: Constants.Triangle.size.width, y: Constants.Triangle.size.height))
        path.addLine(to: CGPoint(x: 0, y: Constants.Triangle.size.height))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = Constants.Triangle.fillCGColor
        
        triangleView.layer.insertSublayer(shape, at: 0)
    }
    
    // MARK: - Layout
    
    private func layout() {
        signUpButton.pin
            .top(5)
            .left(view.pin.safeArea)
            .width(Constants.Buttons.percent)
            .height(Constants.Buttons.height)

        signInButton.pin
            .after(of: signUpButton)
            .right(view.pin.safeArea)
            .marginBottom(Constants.Buttons.marginBottom)
            .width(Constants.Buttons.percent)
            .height(Constants.Buttons.height)
        
       let centerX: CGFloat
       let centerY = signUpButton.frame.maxY

       switch activePage {
       case .signUp:
           centerX = signUpButton.frame.midX - Constants.Triangle.size.width / 2
       case .signIn:
           centerX = signInButton.frame.midX - Constants.Triangle.size.width / 2
       }

       triangleView.pin
           .top(centerY - 8)
           .left(centerX)
        
        let height = (view.frame.height) - signUpButton.frame.maxY
        controllersScrollView.pin
            .below(of: triangleView)
            .marginTop(10)
            .width(100%)
            .height(height)

        signUpViewController?.view.pin
            .topLeft()
            .width(view.frame.width)

        signInViewController?.view.pin
            .top()
            .after(of: signUpViewController?.view ?? UIView())
            .width(view.frame.width)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapSignUpButton() {
        view.endEditing(true)
        controllersScrollView.setContentOffset(.zero, animated: true)
        activePage = .signUp
    }
    
    @objc
    private func didTapSignInButton() {
        view.endEditing(true)
        controllersScrollView.setContentOffset(CGPoint(x: controllersScrollView.frame.width, y: .zero), animated: true)
        activePage = .signIn
    }
    
    // MARK: - Keyboard Actions
    
//    @objc
//    func keyboardWillShow(notification: Notification) {
//        guard
//            let userInfo = notification.userInfo,
//            let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
//        else {
//            return
//        }
//        
//        let keyboardHeight = keyboardFrameInfo.cgRectValue.height
//        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? Constants.Keyboard.duration
//        
//        UIView.animate(withDuration: duration) {
//            self.view.frame.origin.y = -keyboardHeight
//        }
//    }
    
    @objc
    func keyboardWillShow(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        
        let yOffset: CGFloat = 4
        
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? Constants.Keyboard.duration
        
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = -yOffset
        }
    }

    @objc
    func keyboardWillHide(notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? Constants.Keyboard.duration
        
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = 0
        }
    }
        
    @objc
    private func didTapWholeView() {
        view.endEditing(true)
    }
}

// MARK: - UIScrollViewDelegate

extension WelcomeScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard
            scrollView.frame.width > 0,
            scrollView.contentOffset.x >= 0,
            scrollView.contentOffset.x <= scrollView.frame.width
        else {
            return
        }
        
        let triangleViewAvailableMovementLength = signInButton.frame.midX - signUpButton.frame.midX
        let newOriginX = signUpButton.frame.midX +
            (triangleViewAvailableMovementLength / scrollView.frame.width) *
            scrollView.contentOffset.x -
            Constants.Triangle.size.width / 2
        
        triangleView.frame.origin.x = newOriginX
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        activePage = pageIndex == 0 ? .signUp : .signIn
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - WelcomeScreenViewInput

extension WelcomeScreenViewController: WelcomeScreenViewInput {
    func configure(with model: WelcomeScreenViewModel) {
        signInButton.setAttributedTitle(model.signInTitle, for: .normal)
        signUpButton.setAttributedTitle(model.signUpTitle, for: .normal)
    }
    
    func setSignIn(_ view: UIViewController) {
        signInViewController = view
    }
    
    func setSignUp(_ view: UIViewController) {
        signUpViewController = view
    }
}

// MARK: - Constants

private extension WelcomeScreenViewController {
    struct Constants {
        
        static let accentLight = UIColor.UI.accentLight
        
        struct Buttons {
            static let height: CGFloat = 50
            static let marginBottom: CGFloat = 10
            static let percent: Percent = 50%
        }
        
        struct Triangle {
            static let size: CGSize = CGSize(width: 25, height: 15)
            static let fillCGColor: CGColor = UIColor.UI.accentLight.cgColor
        }
        
        struct ScrollView {
            static let cornerRadius: CGFloat = 45
        }
        
        struct Keyboard {
            static let duration: CGFloat = 0.1
        }
    }
}
