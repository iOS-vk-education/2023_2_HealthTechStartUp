//
//  StateChoiceView.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit
import PinLayout

class StateChoiceView: UIView {
    
    // MARK: - Private Properties
    
    private let label = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(isGood: Bool) {
        self.init(frame: .zero)
        self.label.text = isGood.description
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
}

private extension StateChoiceView {
    
    // MARK: - Layout
    
    func layout() {
        label.pin
            .hCenter()
            .vCenter()
            .height(Constants.Label.height)
            .width(Constants.Label.width)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupLabel()
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        
        addSubview(label)
    }
    
    func setupLabel() {
        label.backgroundColor = Constants.Label.backgroundColor
    }
}

// MARK: - Constants

private extension StateChoiceView {
    struct Constants {
        static let backgroundColor: UIColor = .background
        
        struct Label {
            static let backgroundColor: UIColor = .UI.accent
            static let width: CGFloat = 40
            static let height: CGFloat = 100
        }
    }
}
