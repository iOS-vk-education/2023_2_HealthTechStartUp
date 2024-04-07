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
    
    // MARK: - Interface
    
    func configure(with date: Date) {
        dayOfWeekLabel.text = extractDate(date: date, format: "EEE")
        dayOfMonthLabel.text = extractDate(date: date, format: "dd")
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
        backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.UI.accent
        backgroundView.layer.cornerRadius = 8
        selectedBackgroundView = backgroundView
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(dayOfWeekLabel)
        stackView.addArrangedSubview(dayOfMonthLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
    }
    
    func setupLabels() {
        dayOfWeekLabel.textColor = UIColor.Text.grayElement
        dayOfMonthLabel.textColor = UIColor.Text.primary
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
