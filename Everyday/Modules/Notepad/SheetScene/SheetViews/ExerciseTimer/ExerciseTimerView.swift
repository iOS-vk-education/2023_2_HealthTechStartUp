//
//  ExerciseTimerView.swift
//  Everyday
//
//  Created by Alexander on 11.05.2024.
//

import UIKit
import PinLayout

final class ExerciseTimerView: UIView {
    
    // MARK: - Private Properties

    private var output: ExerciseCounterViewOutput?
    
    private let timerView = UIView()
    private let remainingTimeLabel = UILabel()
    private let startButton = UIButton()
    private let resetButton = UIButton()
    private let extraTimeButton = UIButton()
    private let saveButton = UIButton()
    private let closeButton = UIButton()
    
    private var exercise: Exercise?
    
    private var timer = Timer()
    private var remainingTime: Int = Constants.defaultTime
    private var isActive: Bool = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(exercise: Exercise, output: ExerciseCounterViewOutput?) {
        self.init(frame: .zero)
        self.exercise = exercise
        self.output = output
        
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = ExerciseTimerViewModel(remainingTime: String(timeString))
        remainingTimeLabel.attributedText = viewModel.remainingTimeTitle
        startButton.setImage(viewModel.playImage, for: .normal)
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
        resetButton.setAttributedTitle(viewModel.resetTitle, for: .normal)
        extraTimeButton.setAttributedTitle(viewModel.exrtaTimeTitle, for: .normal)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension ExerciseTimerView {
    
    // MARK: - Layout
    
    func layout() {
        let timerViewWidth: CGFloat = bounds.width - Constants.TimerView.padding * 2
        
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
        addSubviews(startButton, resetButton, closeButton, timerView, extraTimeButton, saveButton)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
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
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = ExerciseTimerViewModel(remainingTime: timeString)
        if !isActive {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
            startButton.setImage(viewModel.pauseImage, for: .normal)
        } else {
            timer.invalidate()
            startButton.setImage(viewModel.playImage, for: .normal)
        }
        isActive.toggle()
    }
    
    @objc
    func didTapResetButton() {
        timer.invalidate()
        remainingTime = Constants.defaultTime
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = ExerciseTimerViewModel(remainingTime: timeString)
        isActive = false
        startButton.setImage(viewModel.playImage, for: .normal)
        remainingTimeLabel.text = timeString
    }
    
    @objc
    func didTapCloseButton() {
        output?.didTapExerciseCounterCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
    }
    
    @objc
    func didTapExtraTimeButton() {
    }
    
    // MARK: - Helpers
    
    func secondsToMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        ((seconds / 60), (seconds % 60))
    }
    
    func makeTimeString(_ minutes: Int, _ seconds: Int) -> String {
        String(format: "%02d", minutes) + " : " + String(format: "%02d", seconds)
    }
    
    func fromSecondsToTimeString(_ seconds: Int) -> String {
        let minutesSeconds = secondsToMinutesSeconds(seconds)
        let timeString = makeTimeString(minutesSeconds.0, minutesSeconds.1)
        return timeString
    }

    @objc
    func step() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            timer.invalidate()
        }
        
        let timeString = fromSecondsToTimeString(remainingTime)
        remainingTimeLabel.text = timeString
    }
}

// MARK: - Constants

private extension ExerciseTimerView {
    struct Constants {
        static let defaultTime: Int = 2
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
