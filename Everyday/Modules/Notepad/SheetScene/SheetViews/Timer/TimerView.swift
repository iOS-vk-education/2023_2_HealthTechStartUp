//
//  TimerView.swift
//  Everyday
//
//  Created by Alexander on 11.05.2024.
//

import UIKit
import PinLayout

final class TimerView: UIView {
    
    // MARK: - Private Properties

    private var output: TimerViewOutput?
    
    private let timerView = UIView()
    private let shapeLayer = CAShapeLayer()
    private let remainingTimeLabel = UILabel()
    private let startButton = UIButton()
    private let resetButton = UIButton()
    private let extraTimeButton = UIButton()
    private let saveButton = UIButton()
    private let closeButton = UIButton()
    
    private var timer = Timer()
    private var remainingTime: Int = 0
    private var startRemainingTime: Int = 0
    private var isActive: Bool = false
    private var isPaused: Bool = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(seconds: Int, output: TimerViewOutput?) {
        self.init(frame: .zero)
        self.startRemainingTime = seconds
        self.remainingTime = seconds
        self.output = output
        
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = TimerViewModel(remainingTime: timeString)
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

private extension TimerView {
    
    // MARK: - Layout
    
    func layout() {
        let timerViewWidth: CGFloat = bounds.width - Constants.TimerView.padding * 2
        
        timerView.pin
            .width(timerViewWidth)
            .height(timerViewWidth)
            .center()
        
        circularAnimation()
        
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
        let viewModel = TimerViewModel(remainingTime: timeString)
        
        if !isActive {
            if isPaused {
                resumeAnimation()
            } else {
                basicAnimation()
            }
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
            startButton.setImage(viewModel.pauseImage, for: .normal)
        } else {
            pauseAnimation()
            timer.invalidate()
            startButton.setImage(viewModel.playImage, for: .normal)
        }
        isActive.toggle()
    }
    
    @objc
    func didTapResetButton() {
        shapeLayer.removeAnimation(forKey: "basicAnimation")
        timer.invalidate()
        remainingTime = startRemainingTime
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = TimerViewModel(remainingTime: timeString)
        isPaused = false
        isActive = false
        startButton.setImage(viewModel.playImage, for: .normal)
        remainingTimeLabel.text = timeString
    }
    
    @objc
    func didTapCloseButton() {
        output?.didTapTimerCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
        let result = startRemainingTime - remainingTime
        output?.didTapTimerSaveButton(with: result)
    }
    
    @objc
    func didTapExtraTimeButton() {
        pauseAnimation()
        timer.invalidate()
        remainingTime += 60
        startRemainingTime += 60
        let timeString = fromSecondsToTimeString(remainingTime)
        let viewModel = TimerViewModel(remainingTime: timeString)
        isPaused = false
        isActive = false
        startButton.setImage(viewModel.playImage, for: .normal)
        remainingTimeLabel.text = timeString
    }
    
    // MARK: - Animations
    
    func circularAnimation() {
        let center = CGPoint(x: timerView.frame.width / 2, y: timerView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.UI.accent.cgColor
        timerView.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(remainingTime)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
        isPaused = false
        
        shapeLayer.speed = 1
        shapeLayer.timeOffset = 0
        shapeLayer.beginTime = 0
    }
    
    func resumeAnimation() {
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1
        shapeLayer.timeOffset = 0
        shapeLayer.beginTime = 0
        let timeSincePaused = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayer.beginTime = timeSincePaused
        isPaused = false
    }
    
    func pauseAnimation() {
        let pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0
        shapeLayer.timeOffset = pausedTime
        isPaused = true
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
}

// MARK: - Constants

private extension TimerView {
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
