//
//  NotepadInnerCollectionViewCell.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import UIKit
import PinLayout

class NotepadInnerCollectionViewCell: UICollectionViewCell {
    static let reuseID = "NotepadInnerCollectionViewCell"
    
    private let stackView = UIStackView()
    private let weekdayLabel = UILabel()
    private let dayOfMonthLabel = UILabel()
    
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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
            }
            UIView.animate(withDuration: Constants.BackgroundView.animationDuration) { [weak self] in
                guard let self else {
                    return
                }
                
                backgroundView?.alpha = isSelected ? Constants.BackgroundView.endAlpha : Constants.BackgroundView.startAlpha
            }
        }
    }
    
    // MARK: - Interface
    
    func configure(with viewModel: NotepadInnerCollectionViewCellViewModel) {
        weekdayLabel.attributedText = viewModel.weekday
        dayOfMonthLabel.attributedText = viewModel.dayOfMonth
    }
}

private extension NotepadInnerCollectionViewCell {
    
    // MARK: - Layout
    
    func layout() {
        stackView.pin.all()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupBackgroundView()
        setupStackView()
        contentView.addSubview(stackView)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
    }
    
    func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = Constants.BackgroundView.backgroundColor
        backgroundView.layer.cornerRadius = Constants.BackgroundView.cornerRadius
        self.backgroundView = backgroundView
        self.backgroundView?.alpha = Constants.BackgroundView.startAlpha
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(weekdayLabel)
        stackView.addArrangedSubview(dayOfMonthLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
    }
}

// MARK: - Constants

private extension NotepadInnerCollectionViewCell {
    struct Constants {
        static let backgroundColor: UIColor = .clear
        
        struct BackgroundView {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let cornerRadius: CGFloat = 8
            static let startAlpha: CGFloat = 0.0
            static let endAlpha: CGFloat = 1.0
            static let animationDuration: TimeInterval = 0.3
        }
    }
}
