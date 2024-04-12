//
//  WeigthMeasureView.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit
import PinLayout

class WeightMeasureView: UIView {
    
    // MARK: - Private Properties
    
    private let textField = UITextField()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(weight: Double? = nil) {
        self.init(frame: .zero)
        let textFieldPlaceholder = weight ?? Constants.TextField.defaultValue
        self.textField.placeholder = String(textFieldPlaceholder)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
}

private extension WeightMeasureView {
    
    // MARK: - Layout
    
    func layout() {
        textField.pin
            .hCenter()
            .vCenter()
            .height(Constants.TextField.height)
            .width(Constants.TextField.width)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupTextField()
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        
        addSubview(textField)
    }
    
    func setupTextField() {
        textField.backgroundColor = Constants.TextField.backgroundColor
    }
}

// MARK: - Constants

private extension WeightMeasureView {
    struct Constants {
        static let backgroundColor: UIColor = .background
        
        struct TextField {
            static let backgroundColor: UIColor = .UI.accent
            static let width: CGFloat = 40
            static let height: CGFloat = 100
            static let defaultValue: Double = 0
        }
    }
}
