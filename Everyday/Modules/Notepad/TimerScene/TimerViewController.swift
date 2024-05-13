//
//  TimerViewController.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import UIKit
import PinLayout

final class TimerViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let output: TimerViewOutput
    
    private let timerView = UIView()
    private let remainingTimeLabel = UILabel()
    private let startButton = UIButton()
    private let resetButton = UIButton()
    private let extraTimeButton = UIButton()
    private let saveButton = UIButton()
    private let closeButton = UIButton()
    
    // MARK: - Init

    init(output: TimerViewOutput) {
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
        
        output.didLoadView()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
}

private extension TimerViewController {
    
    // MARK: - Layout
    
    func layout() {
        let timerViewWidth: CGFloat = view.bounds.width - Constants.TimerView.padding * 2
        
        timerView.pin
            .width(timerViewWidth)
            .height(Constants.TimerView.height)
            .hCenter()
            .top(Constants.TimerView.marginTop)
        
        remainingTimeLabel.pin
            .hCenter()
            .vCenter()
            .height(Constants.RemainingTimeLabel.height)
            .width(Constants.RemainingTimeLabel.width)
        
        extraTimeButton.pin
            .below(of: timerView)
            .left(Constants.Button.horizontalMargin)
            .height(Constants.Button.height)
            .width(Constants.Button.width)
        
        resetButton.pin
            .below(of: timerView)
            .right(Constants.Button.horizontalMargin)
            .height(Constants.Button.height)
            .width(Constants.Button.width)
        
        startButton.pin
            .below(of: timerView)
            .hCenter()
            .height(Constants.Button.height)
            .width(Constants.Button.width)
        
        closeButton.pin
            .top(Constants.CloseButton.padding)
            .left(Constants.CloseButton.padding)
            .width(Constants.CloseButton.width)
            .height(Constants.CloseButton.height)
        
        saveButton.pin
            .top(Constants.CloseButton.padding)
            .right(Constants.CloseButton.padding)
            .width(Constants.CloseButton.width)
            .height(Constants.CloseButton.height)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupTimerView()
        setupRemainingTimeLabel()
        setupStartButton()
        setupResetButton()
        setupCloseButton()
        setupSaveButton()
        setupExtraTimeButton()
        
        timerView.addSubview(remainingTimeLabel)
        view.addSubviews(startButton, resetButton, closeButton, timerView, extraTimeButton, saveButton)
    }
    
    func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    func setupTimerView() {
        timerView.backgroundColor = Constants.TimerView.backgroundColor
        timerView.layer.cornerRadius = Constants.TimerView.cornerRadius
    }
    
    func setupStartButton() {
        startButton.tintColor = Constants.Button.backgroundColor
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    func setupResetButton() {
        resetButton.tintColor = Constants.Button.backgroundColor
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    func setupCloseButton() {
        closeButton.tintColor = Constants.Button.backgroundColor
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    func setupSaveButton() {
        saveButton.tintColor = Constants.Button.backgroundColor
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    func setupExtraTimeButton() {
        extraTimeButton.tintColor = Constants.Button.backgroundColor
        extraTimeButton.addTarget(self, action: #selector(didTapExtraTimeButton), for: .touchUpInside)
    }
    
    func setupRemainingTimeLabel() {
        remainingTimeLabel.textAlignment = .center
    }
    
    // MARK: - Actions
    
    @objc
    func didTapStartButton() {
        output.didTapStartButton()
    }
    
    @objc
    func didTapResetButton() {
        output.didTapResetButton()
    }
    
    @objc
    func didTapCloseButton() {
        output.didTapCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
    }
    
    @objc
    func didTapExtraTimeButton() {
    }
}

// MARK: - TimerViewInput

extension TimerViewController: TimerViewInput {
    func configure(with viewModel: TimerViewModel) {
        remainingTimeLabel.attributedText = viewModel.remainingTimeTitle
        startButton.setImage(viewModel.playImage, for: .normal)
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
        resetButton.setAttributedTitle(viewModel.resetTitle, for: .normal)
        extraTimeButton.setAttributedTitle(viewModel.exrtaTimeTitle, for: .normal)
    }
    
    func updateRemainingTime(with time: String) {
        remainingTimeLabel.text = time
    }
    
    func changeMainButtonImage(with image: UIImage?) {
        startButton.setImage(image, for: .normal)
    }
}

// MARK: - Constants

private extension TimerViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        struct Button {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let width: CGFloat = 100
            static let height: CGFloat = 100
            static let horizontalMargin: CGFloat = 50
        }
        
        struct TimerView {
            static let backgroundColor: UIColor = UIColor.Text.primary
            static let padding: CGFloat = 32
            static let cornerRadius: CGFloat = 16
            static let marginTop: CGFloat = 75
            static let height: CGFloat = 100
        }
        
        struct RemainingTimeLabel {
            static let width: CGFloat = 300
            static let height: CGFloat = 80
        }
        
        struct CloseButton {
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
}
