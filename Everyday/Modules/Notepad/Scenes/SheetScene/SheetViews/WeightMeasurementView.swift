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
    
    var output: WeightMeasurementViewOutput?
    
    private let textField = UITextField()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(weight: Double? = nil, output: WeightMeasurementViewOutput) {
        self.init(frame: .zero)
        self.output = output
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
        
        textField.pin
            .width(resultViewWidth)
            .height(Constants.TextField.height)
            .hCenter()
            .top(Constants.TextField.topMargin)
        
        minusButton.pin
            .below(of: textField)
            .left(Constants.Button.horizontalMargin)
            .height(Constants.Button.height)
            .width(Constants.Button.width)
        
        plusButton.pin
            .below(of: textField)
            .right(Constants.Button.horizontalMargin)
            .height(Constants.Button.height)
            .width(Constants.Button.width)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupTextField()
        setupPlusButton()
        setupMinusButton()
        addSubviews(textField, minusButton, plusButton)
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
        textField.font = UIFont.systemFont(ofSize: 72, weight: .bold)
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didEndEditingTextField), for: .editingDidEnd)
    }
    
    func setupMinusButton() {
        minusButton.tintColor = Constants.Button.backgroundColor
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    func setupPlusButton() {
        plusButton.tintColor = Constants.Button.backgroundColor
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
            let valueTextFieldTitle = String(Constants.TextField.defaultValue)
            let valueTextFieldAttributedString = NSAttributedString(string: valueTextFieldTitle, attributes: Styles.valueAttributes)
            textField.attributedText = valueTextFieldAttributedString
        }
    }
    
    @objc
    func dismissKeyboard() {
        endEditing(true)
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
