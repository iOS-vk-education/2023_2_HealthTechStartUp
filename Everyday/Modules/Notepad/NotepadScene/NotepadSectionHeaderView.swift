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
    
    func configure(with workoutDay: (workout: Workout, indexOfDay: Int), and tag: Int, state: NotepadSectionHeaderState) {
        titleLabel.text = workoutDay.workout.name
        descriptionLabel.text = workoutDay.workout.days[workoutDay.indexOfDay].name
        
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
            .horizontally(20)
            .vertically(10)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollapseButton()
    }
    
    func setupView() {
        self.backgroundColor = .systemBackground
        
        self.layer.borderColor = UIColor.label.cgColor
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = 16
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
    }
    
    func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .label
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
    }
    
    func setupCollapseButton() {
        let buttonImage = UIImage(systemName: "chevron.down")
        collapseButton.setImage(buttonImage, for: .normal)
        collapseButton.tintColor = .label
    }
}
