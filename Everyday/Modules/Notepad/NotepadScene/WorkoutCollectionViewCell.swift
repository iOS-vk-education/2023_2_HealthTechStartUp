//
//  WorkoutCollectionViewCell.swift
//  Everyday
//
//  Created by Alexander on 04.04.2024.
//

import UIKit
import PinLayout

class WorkoutCollectionViewCell: UICollectionViewCell {
    static let reuseID = "WorkoutCollectionViewCell"
    
    private var stackView = UIStackView()
    private var dayOfWeekLabel = UILabel()
    private var dayOfMonthLabel = UILabel()
    
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
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self else {
                    return
                }
                
                backgroundView?.alpha = self.isSelected ? 1.0 : 0.0
            }
        }
    }
    
    // MARK: - Interface
    
    func configure(with date: Date) {
        dayOfWeekLabel.text = extractDate(date: date, format: Constants.DayOfWeekLabel.format)
        dayOfMonthLabel.text = extractDate(date: date, format: Constants.DayOfMonthLabel.format)
    }
}

private extension WorkoutCollectionViewCell {
    
    // MARK: - Layout
    
    func layout() {
        stackView.pin.all()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupStackView()
        setupLabels()
        
        addSubview(stackView)
    }
    
    func setupView() {
        backgroundColor = Constants.backgroundColor
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Constants.BackgroundView.backgroundColor
        backgroundView.layer.cornerRadius = Constants.BackgroundView.cornerRadius
        self.backgroundView = backgroundView
        self.backgroundView?.alpha = 0.0
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(dayOfWeekLabel)
        stackView.addArrangedSubview(dayOfMonthLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
    }
    
    func setupLabels() {
        dayOfWeekLabel.textColor = Constants.DayOfWeekLabel.textColor
        dayOfMonthLabel.textColor = Constants.DayOfMonthLabel.textColor
    }
    
    // MARK: - Helpers
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        Calendar.current.isDate(Date(), inSameDayAs: date)
    }
}

// MARK: - Constants

private extension WorkoutCollectionViewCell {
    struct Constants {
        static let backgroundColor: UIColor = .clear
        
        struct BackgroundView {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let cornerRadius: CGFloat = 8
        }
        
        struct DayOfWeekLabel {
            static let format: String = "EEE"
            static let textColor: UIColor = UIColor.Text.grayElement
        }
        
        struct DayOfMonthLabel {
            static let format: String = "dd"
            static let textColor: UIColor = UIColor.Text.primary
        }
    }
}
