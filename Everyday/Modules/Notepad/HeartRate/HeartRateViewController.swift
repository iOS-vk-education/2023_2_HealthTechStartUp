//
//  HeartRateViewController.swift
//  AI_Everyday
//
//  Created by Михаил on 11.05.2024.
//
//

import UIKit
import PinLayout
import AVFoundation

// swiftlint: disable type_body_length 
// чтобы не было потом вопросов что я правлю swiftlint, тут он тоже ругается на 15 строку...
final class HeartRateViewController: UIViewController {
    // MARK: - private properties
    
    private let output: HeartRateViewOutput
    
    private let cameraPreview = Preview()
    private let measureView = UIView()
    private let stressView = UIView()
    private let hrvView = UIView()
    private let heartRateView = UIView()
    
    private let heartRateTitleLabel = UILabel()
    private let hrvTitleLabel = UILabel()
    private let stressTitleLabel = UILabel()
    
    private let heartRateValueLabel = UILabel()
    private let hrvValueLabel = UILabel()
    private let stressValueLabel = UILabel()
    
    private let heartRateDescriptionLabel = UILabel()
    private let hrvDescriptionLabel = UILabel()
    private let stressDescriptionLabel = UILabel()
    
    private let startButton = UIButton()
    private let stopButton = UIButton()
    
    private var counter: Int = 0
    private var timer: Timer?
    
    private let shapeLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private let progressLabel = UILabel()
    private var displayLink: CADisplayLink?
    private var startTime: TimeInterval?
    
    // MARK: - Lifecycle
    
    init(output: HeartRateViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.didLoadView()
        setup()
        
        cameraPreview.session = output.getSession()
        
        view.addSubview(measureView)
        measureView.addSubviews(stressView, hrvView, heartRateView, startButton, stopButton, progressLabel)
        view.layer.addSublayer(trackLayer)
        view.layer.insertSublayer(cameraPreview.videoPreviewLayer, below: measureView.layer)
        view.layer.addSublayer(shapeLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.startSession()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let connection = cameraPreview.videoPreviewLayer.connection {
            let previewLayerConnection: AVCaptureConnection = connection
            
            previewLayerConnection.videoRotationAngle = 90
            cameraPreview.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        }
        
        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        displayLink?.invalidate()
        displayLink = nil
    }
    
    // MARK: - setup
    
    private func setup() {
        setupLoadIndicator()
        setupViews()
        setupLabels()
        setupButtons()
    }
    
    private func setupLoadIndicator() {
        let centerYOffset = view.center.y + Constants.LoadIndicator.centerOffset
        let center = CGPoint(x: view.center.x, y: centerYOffset)
        let circularPath = UIBezierPath(arcCenter: center, radius: Constants.LoadIndicator.radius, 
                                        startAngle: Constants.LoadIndicator.startAngle, endAngle: Constants.LoadIndicator.endAngle, clockwise: true)
        
        for layer in [trackLayer, shapeLayer] {
            layer.path = circularPath.cgPath
            layer.lineWidth = Constants.LoadIndicator.lineWidth
            layer.lineCap = CAShapeLayerLineCap.round
            layer.fillColor = UIColor.clear.cgColor
        }
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.strokeEnd = Constants.LoadIndicator.strokeEnd
        
        progressLabel.frame = Constants.LoadIndicator.size
        let progressCenter = CGPoint(x: view.center.x, y: centerYOffset - Constants.LoadIndicator.loaderCenterOffset)
        progressLabel.center = progressCenter
    }
    
    private func setupViews() {
        measureView.backgroundColor = .clear
        for subview in [stressView, hrvView, heartRateView] {
            subview.backgroundColor = .white
            subview.layer.cornerRadius = Constants.MeasureSubviews.cornerRadius
        }
        
        stressView.addSubviews(stressTitleLabel, stressValueLabel, stressDescriptionLabel)
        hrvView.addSubviews(hrvTitleLabel, hrvValueLabel, hrvDescriptionLabel)
        heartRateView.addSubviews(heartRateTitleLabel, heartRateValueLabel, heartRateDescriptionLabel)
    }
    
    private func setupLabels() {
        stressDescriptionLabel.backgroundColor = .black
        stressDescriptionLabel.textColor = .white
        stressDescriptionLabel.layer.cornerRadius = Constants.Labels.cornerRadius
        stressDescriptionLabel.clipsToBounds = true
    }
    
    private func setupButtons() {
        startButton.backgroundColor = Constants.accent
        startButton.layer.cornerRadius = Constants.Buttons.cornerRadius
        
        stopButton.backgroundColor = .lightGray
        stopButton.layer.cornerRadius = Constants.Buttons.cornerRadius
        stopButton.isHidden = true
        
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    // MARK: - layout
    
    private func layout() {
        measureView.pin
            .top(view.pin.safeArea.top)
            .hCenter()
            .height(view.frame.height)
            .width(view.frame.width)
        
        let spacing = (((measureView.frame.width - Constants.MeasureSubviews.size.width * 3 -
                         Constants.MeasureSubviews.marginHorizontal * 2) / 2) * 100).rounded() / 100
        
        stressView.pin
            .top(Constants.MeasureSubviews.marginTop)
            .left(Constants.MeasureSubviews.marginHorizontal)
            .size(Constants.MeasureSubviews.size)
        
        hrvView.pin
            .top(Constants.MeasureSubviews.marginTop)
            .after(of: stressView)
            .marginLeft(spacing)
            .size(Constants.MeasureSubviews.size)
        
        heartRateView.pin
            .top(Constants.MeasureSubviews.marginTop)
            .after(of: hrvView)
            .marginLeft(spacing)
            .size(Constants.MeasureSubviews.size)
        
        stressTitleLabel.pin
            .top()
            .hCenter()
            .size(Constants.Labels.titleSize)
        
        hrvTitleLabel.pin
            .top()
            .hCenter()
            .size(Constants.Labels.titleSize)
        
        heartRateTitleLabel.pin
            .top()
            .hCenter()
            .size(Constants.Labels.titleSize)
        
        stressValueLabel.pin
            .below(of: stressTitleLabel, aligned: .center)
            .size(Constants.Labels.valueSize)
        
        hrvValueLabel.pin
            .below(of: hrvTitleLabel, aligned: .center)
            .size(Constants.Labels.valueSize)
        
        heartRateValueLabel.pin
            .below(of: heartRateTitleLabel, aligned: .center)
            .size(Constants.Labels.valueSize)
        
        stressDescriptionLabel.pin
            .below(of: stressValueLabel, aligned: .center)
            .size(Constants.Labels.descriptionSize)
            
        hrvDescriptionLabel.pin
            .below(of: hrvValueLabel, aligned: .center)
            .size(Constants.Labels.descriptionSize)
        
        heartRateDescriptionLabel.pin
            .below(of: heartRateValueLabel, aligned: .center)
            .size(Constants.Labels.descriptionSize)
        
        startButton.pin
            .hCenter()
            .bottom(view.pin.safeArea.bottom + Constants.Buttons.bottom)
            .size(Constants.Buttons.size)
        
        stopButton.pin
        .hCenter()
        .bottom(view.pin.safeArea.bottom + Constants.Buttons.bottom)
        .size(Constants.Buttons.size)
        
        cameraPreview.videoPreviewLayer.frame = self.view.layer.frame
    }
    
    // MARK: - private functions
    
    private func clearLabels() {
        stressValueLabel.attributedText = NSAttributedString(string: "---", attributes: Constants.Styles.valueAttributes)
        hrvValueLabel.attributedText = NSAttributedString(string: "---", attributes: Constants.Styles.valueAttributes)
        heartRateValueLabel.attributedText = NSAttributedString(string: "---", attributes: Constants.Styles.valueAttributes)
        stressDescriptionLabel.attributedText = NSAttributedString(string: "---", attributes: Constants.Styles.descriptionAttributes)
    }
    
    private func updateUIForWaiting() {
        clearLabels()
        stressDescriptionLabel.backgroundColor = .black
    }
    
    private func resetMonitoring() {
        counter = 0
        timer?.invalidate()
        clearLabels()
    }
    
    private func animateProgressLayer(duration: TimeInterval) {
        startTime = CACurrentMediaTime()
        
        let animation = CABasicAnimation(keyPath: Constants.LoadIndicator.keyPath)
        animation.fromValue = Constants.LoadIndicator.fromValue
        animation.toValue = Constants.LoadIndicator.toValue
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: Constants.LoadIndicator.key)
        
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(updateProgressLabel))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    private func startMonitoring() {
        animateProgressLayer(duration: Constants.LoadIndicator.duration)
        resetMonitoring()

        output.startMonitoring()

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateMonitoring), userInfo: nil, repeats: true)
        
        output.setMeasuringMode()
    }
    
    private func stopProgressAnimation() {
        displayLink?.invalidate()
        displayLink = nil
        let currentTime = CACurrentMediaTime()
        
        guard let start = startTime else {
            return
        }
        let elapsed = currentTime - start
        let duration = Constants.LoadIndicator.duration
        let normalizedProgress = min(max(elapsed / duration, 0), 1)
        shapeLayer.strokeEnd = CGFloat(normalizedProgress)
        progressLabel.text = "\(Int(normalizedProgress * 100))%"
    }
    
    private func stopShapeLayerAnimation() {
        shapeLayer.removeAnimation(forKey: Constants.LoadIndicator.key)
        displayLink?.invalidate()
        displayLink = nil
    }
    
    private func updateStress(stress: Double) {
        if stress < 0 {
            return
        }
        
        if stress.isNaN {
            stressValueLabel.attributedText = NSAttributedString(string: "NaN", attributes: Constants.Styles.valueAttributes)
            stressDescriptionLabel.attributedText = NSAttributedString(string: "---", attributes: Constants.Styles.descriptionAttributes)
            stressDescriptionLabel.backgroundColor = .black
        } else {
            let stressRounded = round(stress * 100) / 100
            stressValueLabel.attributedText = NSAttributedString(string: "\(stressRounded)", attributes: Constants.Styles.valueAttributes)
        
            if stressRounded < 1.5 {
                stressDescriptionLabel.attributedText = NSAttributedString(string: "Normal", attributes: Constants.Styles.descriptionAttributes)
                stressDescriptionLabel.backgroundColor = UIColor(red: 12 / 256, green: 128 / 256, blue: 42 / 256, alpha: 1.0)
            } else if (1.5 <= stressRounded) && (stressRounded < 2.5) {
                stressDescriptionLabel.attributedText = NSAttributedString(string: "Mild", attributes: Constants.Styles.descriptionAttributes)
                stressDescriptionLabel.backgroundColor = .blue
            } else if (2.5 <= stressRounded) && (stressRounded < 3.5) {
                stressDescriptionLabel.attributedText = NSAttributedString(string: "High", attributes: Constants.Styles.descriptionAttributes)
                stressDescriptionLabel.backgroundColor = .orange
            } else if 3.5 <= stressRounded {
                stressDescriptionLabel.attributedText = NSAttributedString(string: "Very High", attributes: Constants.Styles.descriptionAttributes)
                stressDescriptionLabel.backgroundColor = .red
            }
        }
    }
    
    private func updateHeartRate(heartRate: Double) {
        if heartRate < 0 {
            return
        }
        
        if heartRate.isNaN {
           heartRateValueLabel.attributedText = NSAttributedString(string: "NaN", attributes: Constants.Styles.valueAttributes)
        } else {
           heartRateValueLabel.attributedText = NSAttributedString(string: "\(round(heartRate * 10) / 10)", attributes: Constants.Styles.valueAttributes)
        }
    }
    
    private func updateHRV(heartRateVariability: Double) {
        if heartRateVariability < 0 {
            return
        }
        
        if heartRateVariability.isNaN {
            hrvValueLabel.attributedText = NSAttributedString(string: "NaN", attributes: Constants.Styles.valueAttributes)
        } else {
            hrvValueLabel.attributedText = NSAttributedString(string: "\(Int(round(heartRateVariability * 1000)))",
                                                              attributes: Constants.Styles.valueAttributes)
        }
    }
    
    // MARK: - actions
    
    @objc
    private func updateMonitoring() {
        output.getEstimates()
    }
    
    @objc
    private func appMovedToBackground() {
        counter = 0
        timer?.invalidate()
        output.stopSession()
    }
    
    @objc
    private func updateProgressLabel() {
        guard let start = startTime else {
            return
        }
        
        let currentTime = CACurrentMediaTime()
        let elapsed = currentTime - start
        let duration = Constants.LoadIndicator.duration
        let percentage = min(max((elapsed / duration), 0), 1)

        progressLabel.attributedText = NSAttributedString(string: "\(Int(percentage * 100))%", attributes: Constants.Styles.progressAttributes)
        shapeLayer.strokeEnd = CGFloat(percentage)

        if elapsed >= duration {
            displayLink?.invalidate()
            displayLink = nil
        }
    }
    
    @objc
    private func didTapStopButton() {
        stopProgressAnimation()
        stopShapeLayerAnimation()
        counter = 0
        timer?.invalidate()
        output.stopSession()
    }
    
    @objc
    private func didTapStartButton() {
        startMonitoring()
    }
}

// MARK: - extensions

extension HeartRateViewController: HeartRateViewInput {
    func updateResults(stress: Double, heartRate: Double, heartRateVariability: Double) {
        updateHeartRate(heartRate: heartRate)
        updateHRV(heartRateVariability: heartRateVariability)
        updateStress(stress: stress)
    }
    
    func incrementCounter() {
        counter += 1
        updateUIForWaiting()
    }
    
    func clearLabelsValue() {
        clearLabels()
    }
    
    func moveUIToStoppedMode() {
        heartRateView.isHidden = true
        hrvView.isHidden = true
        stressView.isHidden = true
        stopButton.isHidden = true
        
        startButton.isHidden = false
    }
    
    func stopMonitoringAfterError() {
        stopProgressAnimation()
        stopShapeLayerAnimation()
        counter = 0
        timer?.invalidate()
        output.stopSession()
    }
    
     func moveUIToMeasuringMode() {
        heartRateView.isHidden = false
        hrvView.isHidden = false
        stressView.isHidden = false
        stopButton.isHidden = false
        
        startButton.isHidden = true
    }
    
    func configure(with viewModel: HeartRateViewModel) {
        heartRateTitleLabel.attributedText = viewModel.heartRateTitleLabel
        heartRateDescriptionLabel.attributedText = viewModel.heartRateDescriptionLabel
        
        hrvTitleLabel.attributedText = viewModel.hrvTitleLabel
        hrvDescriptionLabel.attributedText = viewModel.hrvDescriptionLabel
        
        stressTitleLabel.attributedText = viewModel.stressTitleLabel
        
        startButton.setAttributedTitle(viewModel.startButtonTitle, for: .normal)
        stopButton.setAttributedTitle(viewModel.stopButtonTitle, for: .normal)
    }
}

private extension HeartRateViewController {
    struct Constants {
        static let accent: UIColor = {
            guard let color = UIColor(named: "Pistachio") else {
                fatalError("Can't find color: Pistachio")
            }
            
            return color
        }()
        
        static let gray: UIColor = .gray
        
        struct LoadIndicator {
            static let lineWidth: CGFloat = 6
            static let strokeEnd: CGFloat = 0
            static let radius: CGFloat = 60
            static let startAngle: CGFloat = -CGFloat.pi / 2
            static let endAngle: CGFloat = 2 * CGFloat.pi
            static let fromValue: CGFloat = 0
            static let toValue: CGFloat = 1
            static let keyPath: String = "strokeEnd"
            static let key: String = "progressAnim"
            static let duration: CGFloat = 70
            static let centerOffset: CGFloat = 220
            static let loaderCenterOffset: CGFloat = 46
            static let size: CGRect = CGRect(x: 0, y: 0, width: 100, height: 40)
        }
        
        struct MeasureSubviews {
            static let cornerRadius: CGFloat = 8
            static let size: CGSize = CGSize(width: 120, height: 110)
            static let marginHorizontal: CGFloat = 2
            static let marginTop: CGFloat = 5
            static let colorOpacity: CGFloat = 0.2
        }
        
        struct Labels {
            static let titleSize: CGSize = CGSize(width: 110, height: 30)
            static let valueSize: CGSize = CGSize(width: 110, height: 50)
            static let descriptionSize: CGSize = CGSize(width: 110, height: 24)
            static let cornerRadius: CGFloat = 8
        }
        
        struct Buttons {
            static let size: CGSize = CGSize(width: 240, height: 60)
            static let cornerRadius: CGFloat = 8
            static let bottom: CGFloat = 40
        }
        
        struct Styles {
            static let paragraphStyle: NSMutableParagraphStyle = {
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }()
            
            static let valueAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            static let descriptionAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.boldSystemFont(ofSize: 16),
                .paragraphStyle: paragraphStyle
            ]
            
            static let progressAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.boldSystemFont(ofSize: 38),
                .paragraphStyle: paragraphStyle
            ]
        }
    }
}
// swiftlint:enable type_body_length
