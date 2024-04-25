//
//  WeightMeasurementView.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import UIKit
import PinLayout

class WeightMeasurementView: UIView {
    
    // MARK: - Private Properties
    
    private let closeButton = UIButton()
    private let saveButton = UIButton()
    
    private let textField = UITextField()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private var output: WeightMeasurementViewOutput?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(weight: Double? = nil, output: WeightMeasurementViewOutput?) {
        self.init(frame: .zero)
        self.output = output
        
        let viewModel = WeightMeasurementViewModel(value: weight)
        textField.attributedText = viewModel.value
        
        setupWeightView()
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension WeightMeasurementView {
    
    // MARK: - Layout
    
    func layout() {
        let resultViewWidth: CGFloat = bounds.width - Constants.TextField.padding * 2
        
        closeButton.pin
            .top(Constants.Button.padding + pin.safeArea.top)
            .left(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        saveButton.pin
            .top(Constants.Button.padding + pin.safeArea.top)
            .right(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        textField.pin
            .below(of: [closeButton, saveButton])
            .marginTop(Constants.Button.padding)
            .width(resultViewWidth)
            .height(Constants.TextField.height)
            .hCenter()
        
        minusButton.pin
            .below(of: textField)
            .left(Constants.ChangeButton.horizontalMargin)
            .height(Constants.ChangeButton.height)
            .width(Constants.ChangeButton.width)
        
        plusButton.pin
            .below(of: textField)
            .right(Constants.ChangeButton.horizontalMargin)
            .height(Constants.ChangeButton.height)
            .width(Constants.ChangeButton.width)
    }
    
    // MARK: - Configure
    
    func configureButtons() {
        let cameraModel = CameraModel()
        let viewModel = SheetViewModel(sheetType: .camera(model: cameraModel))
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupCloseButton()
        setupSaveButton()
        configureButtons()
        setupView()
        setupTextField()
        setupPlusButton()
        setupMinusButton()
        addSubviews(closeButton, saveButton, textField, minusButton, plusButton)
    }
    
    func setupCloseButton() {
        closeButton.tintColor = Constants.Button.backgroundColor
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    func setupSaveButton() {
        saveButton.tintColor = Constants.Button.backgroundColor
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    func setupTextField() {
        textField.backgroundColor = Constants.TextField.backgroundColor
        textField.layer.cornerRadius = Constants.TextField.cornerRadius
        textField.textAlignment = .center
        textField.textColor = Constants.TextField.textColor
        textField.placeholder = "0,0"
        textField.font = UIFont.systemFont(ofSize: 72, weight: .bold)
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didEndEditingTextField), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(didEditTextField), for: .editingChanged)
    }
    
    func setupMinusButton() {
        minusButton.tintColor = Constants.ChangeButton.backgroundColor
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    func setupPlusButton() {
        plusButton.tintColor = Constants.ChangeButton.backgroundColor
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapMinusButton() {
        guard
            let attributedText = textField.attributedText,
            let result = Int(attributedText.string),
            result > 0
        else {
            return
        }
        
        let newAttributedText = NSMutableAttributedString(attributedString: attributedText)
        newAttributedText.mutableString.setString(String(result - 1))
        textField.attributedText = newAttributedText
    }
    
    @objc
    func didTapPlusButton() {
        guard
            let attributedText = textField.attributedText,
            let result = Int(attributedText.string)
        else {
            return
        }
        
        let newAttributedText = NSMutableAttributedString(attributedString: attributedText)
        newAttributedText.mutableString.setString(String(result + 1))
        textField.attributedText = newAttributedText
    }
    
    @objc
    func didEndEditingTextField() {
        guard
            let attributedText = textField.attributedText
        else {
            return
        }
        
        let resultText = attributedText.string
        if resultText.isEmpty || !resultText.isDouble || Int(resultText) ?? 0 < 0 {
            let valueTextFieldTitle = String("0,0")
            let valueTextFieldAttributedString = NSAttributedString(string: valueTextFieldTitle, attributes: Styles.valueAttributes)
            textField.attributedText = valueTextFieldAttributedString
        }
    }
    
    @objc
    func didEditTextField() {
        guard
            let attributedText = textField.attributedText
        else {
            return
        }
        
        let resultText = attributedText.string
        if resultText.isEmpty || !resultText.isDouble || Int(resultText) ?? 0 < 0 {
//            output?.didEditTextField(with: nil)
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let number = formatter.number(from: resultText) {
//                output?.didEditTextField(with: Double(truncating: number))
            }
        }
    }
    
    @objc
    func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc
    func didTapCloseButton() {
        output?.didTapWeightMeasurementCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
        guard
            let attributedText = textField.attributedText
        else {
            return
        }
        
        let resultText = attributedText.string
        if resultText.isEmpty || !resultText.isDouble || Int(resultText) ?? 0 < 0 {
            output?.didTapSaveButton(with: nil)
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let number = formatter.number(from: resultText) {
                output?.didTapSaveButton(with: Double(truncating: number))
            }
        }
    }
    
    // MARK: - Helpers
    
    func setupWeightView() {
        minusButton.isHidden = true
        plusButton.isHidden = true
    }
}

// MARK: - ViewInput

protocol WeightMeasurementViewInput: AnyObject {
    func configure(with viewModel: WeightMeasurementViewModel)
}

extension WeightMeasurementView: WeightMeasurementViewInput {
    func configure(with viewModel: WeightMeasurementViewModel) {
        textField.attributedText = viewModel.value
        minusButton.setImage(viewModel.minusImage, for: .normal)
        plusButton.setImage(viewModel.plusImage, for: .normal)
    }
}

// MARK: - Constants

private extension WeightMeasurementView {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        struct Button {
            static let backgroundColor: UIColor = .UI.accent
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
        
        struct ChangeButton {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let width: CGFloat = 100
            static let height: CGFloat = 100
            static let horizontalMargin: CGFloat = 50
        }
        
        struct TextField {
            static let backgroundColor: UIColor = UIColor.Text.primary
            static let textColor: UIColor = UIColor.UI.accent
            static let padding: CGFloat = 32
            static let cornerRadius: CGFloat = 16
            static let height: CGFloat = 100
            static let defaultValue: Double = 0.0
            static let topMargin: CGFloat = 20
        }
    }
    
    struct Styles {
        static let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 72, weight: .bold),
            .foregroundColor: UIColor.UI.accent
        ]
    }
}
