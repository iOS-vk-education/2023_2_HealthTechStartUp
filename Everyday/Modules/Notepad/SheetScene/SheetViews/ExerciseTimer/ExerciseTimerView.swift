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

    private var output: ExerciseTimerViewOutput?
    
    private let timerView = UIView()
    private let remainingTimeLabel = UILabel()
    private let startButton = UIButton()
    private let resetButton = UIButton()
    private let extraTimeButton = UIButton()
    private let saveButton = UIButton()
    private let closeButton = UIButton()
    
    private var exercise: Exercise = .init()
    
    private var timer = Timer()
    private var remainingTime: Int = 0
    private var startRemainingTime: Int = 0
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
    
    convenience init(exercise: Exercise, output: ExerciseTimerViewOutput?) {
        self.init(frame: .zero)
        self.exercise = exercise
        self.startRemainingTime = fromTimeStringToSeconds(exercise.result)
        self.remainingTime = startRemainingTime
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
        setupButtons()
        
        timerView.addSubview(remainingTimeLabel)
        addSubviews(startButton, resetButton, closeButton, timerView, extraTimeButton, saveButton)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
    }
    
    func setupTimerView() {
        timerView.backgroundColor = Constants.TimerView.backgroundColor.withAlphaComponent(Constants.TimerView.colorOpacity)
        timerView.layer.cornerRadius = Constants.TimerView.cornerRadius
    }
    
    func setupButtons() {
        [startButton, resetButton, closeButton, saveButton, extraTimeButton].forEach { button in
            button.tintColor = Constants.Button.tintColor
        }
        
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        extraTimeButton.addTarget(self, action: #selector(didTapExtraTimeButton), for: .touchUpInside)
    }
    
    func setupRemainingTimeLabel() {
        remainingTimeLabel.textAlignment = .center
    }

    // MARK: - Actions
    
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
        remainingTime = startRemainingTime
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = ExerciseTimerViewModel(remainingTime: timeString)
        isActive = false
        startButton.setImage(viewModel.playImage, for: .normal)
        remainingTimeLabel.text = timeString
    }
    
    @objc
    func didTapCloseButton() {
        output?.didTapExerciseTimerCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
        let result = startRemainingTime - remainingTime
        exercise.result = fromSecondsToTimeString(result)
        output?.didTapExerciseTimerSaveButton(with: exercise)
    }
    
    @objc
    func didTapExtraTimeButton() {
        timer.invalidate()
        remainingTime += 60
        startRemainingTime += 60
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = ExerciseTimerViewModel(remainingTime: timeString)
        isActive = false
        startButton.setImage(viewModel.playImage, for: .normal)
        remainingTimeLabel.text = timeString
    }
    
    // MARK: - Helpers
    
    func secondsToMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        ((seconds / 60), (seconds % 60))
    }
    
    func makeTimeString(_ minutes: Int, _ seconds: Int) -> String {
        String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
    }
    
    func fromSecondsToTimeString(_ seconds: Int) -> String {
        let minutesSeconds = secondsToMinutesSeconds(seconds)
        let timeString = makeTimeString(minutesSeconds.0, minutesSeconds.1)
        return timeString
    }
    
    func makeMinutesSeconds(_ timeString: String) -> (minutes: Int, seconds: Int) {
        let components = timeString.split(separator: ":")
        guard
            components.count == 2,
            let minutes = Int(components[0]),
            let seconds = Int(components[1])
        else {
            return (0, 0)
        }
        
        return (minutes, seconds)
    }
    
    func minutesSecondsToSeconds(_ minutes: Int, _ seconds: Int) -> Int {
        minutes * 60 + seconds
    }
    
    func fromTimeStringToSeconds(_ timeString: String) -> Int {
        let minutesSeconds = makeMinutesSeconds(timeString)
        let seconds = minutesSecondsToSeconds(minutesSeconds.0, minutesSeconds.1)
        return seconds
    }
}

// MARK: - Constants

private extension ExerciseTimerView {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        struct Button {
            static let tintColor: UIColor = UIColor.UI.accent
            static let width: CGFloat = 100
            static let height: CGFloat = 100
            static let horizontalMargin: CGFloat = 50
        }
        
        struct TimerView {
            static let backgroundColor: UIColor = UIColor.gray
            static let colorOpacity: CGFloat = 0.1
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
