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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    func configure(with date: Date) {
        dayOfWeekLabel.text = extractDate(date: date, format: "EEE")
        dayOfMonthLabel.text = extractDate(date: date, format: "dd")
        
        backgroundColor = isToday(date: date) ? .systemMint : .clear
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
        
        addSubview(stackView)
    }
    
    func setupView() {
        layer.cornerRadius = 8
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(dayOfWeekLabel)
        stackView.addArrangedSubview(dayOfMonthLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
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
