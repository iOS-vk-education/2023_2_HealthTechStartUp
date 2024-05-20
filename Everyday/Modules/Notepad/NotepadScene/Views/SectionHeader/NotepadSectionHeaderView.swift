//
//  NotepadSectionHeaderView.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit
import PinLayout

enum NotepadSectionHeaderState {
    case open
    case collapse
}

class NotepadSectionHeaderView: UIView {
    
    // MARK: - Private Properties
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let collapseButton = UIButton()
    
    private var state: NotepadSectionHeaderState = .collapse
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: - Interface
    
    func configure(with viewModel: NotepadHeaderViewModel, and tag: Int, state: NotepadSectionHeaderState) {
        titleLabel.attributedText = viewModel.title
        descriptionLabel.attributedText = viewModel.desciption
        if state == .open {
            collapseButton.setImage(viewModel.collapseImage, for: .normal)
        }
        
        self.tag = tag
        collapseButton.tag = tag
        
        self.state = state
    }
    
    func addActions(_ target: Any?, viewAction: Selector, buttonAction: Selector) {
        switch state {
        case .collapse:
            let tapGesture = UITapGestureRecognizer(target: target, action: viewAction)
            self.addGestureRecognizer(tapGesture)
        case .open:
            collapseButton.addTarget(target, action: buttonAction, for: .touchUpInside)
        }
    }
}

private extension NotepadSectionHeaderView {
    
    // MARK: - Layout
    
    func layout() {
        stackView.pin
            .horizontally(Constants.horizontalMargin)
            .vertically(Constants.verticalMargin)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupStackView()
        setupCollapseButton()
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
    }
    
    func setupStackView() {
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(collapseButton)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
    }
    
    func setupCollapseButton() {
        collapseButton.tintColor = Constants.tintColor
    }
}

// MARK: - Constants

private extension NotepadSectionHeaderView {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.UI.accent
        static let tintColor: UIColor = UIColor.Text.primary
        
        static let horizontalMargin: CGFloat = 20
        static let verticalMargin: CGFloat = 10
        
        static let cornerRadius: CGFloat = 16
    }
}
