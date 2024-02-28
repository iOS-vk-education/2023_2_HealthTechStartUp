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
            .top(200)
            .width(200)
            .height(40)
        
        startButton.pin
            .below(of: remainingTimeLabel)
            .hCenter()
            .height(40)
            .width(100)
        
        stopButton.pin
            .below(of: startButton)
            .hCenter()
            .height(40)
            .width(100)
        
        resetButton.pin
            .below(of: stopButton)
            .hCenter()
            .height(40)
            .width(100)
        
        skipButton.pin
            .below(of: resetButton)
            .hCenter()
            .height(40)
            .width(200)
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
        view.backgroundColor = .systemBackground
    }
    
    func setupStartButton() {
        startButton.backgroundColor = .systemMint
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    func setupStopButton() {
        stopButton.backgroundColor = .systemMint
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
    }
    
    func setupResetButton() {
        resetButton.backgroundColor = .systemMint
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    func setupSkipButton() {
        skipButton.backgroundColor = .systemMint
        skipButton.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
    }
    
    func setupRemainingTimeLabel() {
        remainingTimeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
