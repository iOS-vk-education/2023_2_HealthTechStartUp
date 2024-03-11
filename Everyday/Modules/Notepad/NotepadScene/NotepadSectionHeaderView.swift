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
    
    // MARK: - Private properties
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        layout()
    }
    
    // MARK: - Interface
    
    func configure(with viewModel: NotepadHeaderViewModel, and tag: Int, state: NotepadSectionHeaderState) {
        titleLabel.attributedText = viewModel.title
        descriptionLabel.attributedText = viewModel.desciption
        collapseButton.setImage(viewModel.collapseImage, for: .normal)
        
        self.tag = tag
        collapseButton.tag = tag
        
        self.state = state
    }
    
    func addActions(_ target: Any?, viewAction: Selector, buttonAction: Selector) {
        switch state {
        case .open:
            let tapGesture = UITapGestureRecognizer(target: target, action: viewAction)
            self.addGestureRecognizer(tapGesture)
        case .collapse:
            collapseButton.addTarget(target, action: buttonAction, for: .touchUpInside)
        }
    }
}

private extension NotepadSectionHeaderView {
    
    // MARK: - Layout
    
    func layout() {
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        
        let mainStackView = UIStackView(arrangedSubviews: [labelStackView, collapseButton])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .equalSpacing
        
        self.addSubview(mainStackView)
        
        mainStackView.pin
            .horizontally(Constants.horizontalMargin)
            .vertically(Constants.verticalMargin)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupCollapseButton()
    }
    
    func setupView() {
        self.backgroundColor = Constants.backgroundColor
        self.layer.cornerRadius = Constants.cornerRadius
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
