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
    
    private let remainingTimeLabel = UILabel()
    private let startButton = UIButton()
    private let stopButton = UIButton()
    private let resetButton = UIButton()
    private let skipButton = UIButton()
    
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
        remainingTimeLabel.pin
            .hCenter()
            .top(Constants.RemainingTimeLabel.marginTop)
            .height(Constants.contentHeight)
            .width(Constants.contentWidth)
        
        startButton.pin
            .below(of: remainingTimeLabel)
            .hCenter()
            .height(Constants.contentHeight)
            .width(Constants.contentWidth)
        
        stopButton.pin
            .below(of: startButton)
            .hCenter()
            .height(Constants.contentHeight)
            .width(Constants.contentWidth)
        
        resetButton.pin
            .below(of: stopButton)
            .hCenter()
            .height(Constants.contentHeight)
            .width(Constants.contentWidth)
        
        skipButton.pin
            .below(of: resetButton)
            .hCenter()
            .height(Constants.contentHeight)
            .width(Constants.contentWidth)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupRemainingTimeLabel()
        setupStartButton()
        setupStopButton()
        setupResetButton()
        setupSkipButton()
        
        view.addSubviews(startButton, stopButton, resetButton, skipButton, remainingTimeLabel)
    }
    
    func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    func setupStartButton() {
        startButton.backgroundColor = Constants.Button.backgroundColor
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    func setupStopButton() {
        stopButton.backgroundColor = Constants.Button.backgroundColor
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
    }
    
    func setupResetButton() {
        resetButton.backgroundColor = Constants.Button.backgroundColor
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    func setupSkipButton() {
        skipButton.backgroundColor = Constants.Button.backgroundColor
        skipButton.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
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
    func didTapStopButton() {
        output.didTapStopButton()
    }
    
    @objc
    func didTapResetButton() {
        output.didTapResetButton()
    }
    
    @objc
    func didTapSkipButton() {
        output.didTapSkipButton()
    }
}

// MARK: - TimerViewInput

extension TimerViewController: TimerViewInput {
    func configure(with viewModel: TimerViewModel) {
        remainingTimeLabel.attributedText = viewModel.remainingTimeTitle
        startButton.setAttributedTitle(viewModel.startTitle, for: .normal)
        stopButton.setAttributedTitle(viewModel.stopTitle, for: .normal)
        resetButton.setAttributedTitle(viewModel.resetTitle, for: .normal)
        skipButton.setAttributedTitle(viewModel.skipTitle, for: .normal)
    }
    
    func updateRemainingTime(with time: Int) {
        remainingTimeLabel.text = String(time)
    }
}

// MARK: - Constants

private extension TimerViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        static let contentWidth: CGFloat = 100
        static let contentHeight: CGFloat = 100
        
        struct Button {
            static let backgroundColor: UIColor = UIColor.UI.accent
        }
        
        struct RemainingTimeLabel {
            static let marginTop: CGFloat = 200
        }
    }
}
