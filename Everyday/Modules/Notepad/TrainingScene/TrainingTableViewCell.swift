//
//  TrainingTableViewCell.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit
import PinLayout

class TrainingTableViewCell: UITableViewCell {
    static let reuseID = "TrainingTableViewCell"
    
    // MARK: - Private properties
    
    private let counterLabel = UILabel()
    private let circleImageView = UIImageView()
    private let numberView = UIView()
    private let exerciseNameLabel = UILabel()
    private let resultLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: - Interface

    func configure(with viewModel: TrainingTableViewCellViewModel, and index: Int, isDone: Bool) {
        exerciseNameLabel.attributedText = viewModel.title
        resultLabel.attributedText = viewModel.result
        counterLabel.attributedText = viewModel.number
        
        counterLabel.text = String(index + 1)
        
        if isDone {
            circleImageView.image = viewModel.circleFilled
            circleImageView.tintColor = Constants.CounterLabel.checkedColor
        } else {
            circleImageView.image = viewModel.circleFilled
            circleImageView.tintColor = Constants.CounterLabel.uncheckedColor
        }
    }
    
    func updateResult(with result: String) {
        resultLabel.text = result
    }
}

private extension TrainingTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        numberView.pin
            .left(Constants.horizontalMargin)
            .width(Constants.CounterLabel.width)
            .height(Constants.contentHeight)
            .vCenter()
        
        circleImageView.pin
            .width(Constants.CounterLabel.width)
            .height(Constants.contentHeight)
            .vCenter()
            .hCenter()
        
        counterLabel.pin
            .width(Constants.CounterLabel.width)
            .height(Constants.contentHeight)
            .vCenter()
            .hCenter()
        
        exerciseNameLabel.pin
            .after(of: counterLabel)
            .marginLeft(Constants.horizontalMargin)
            .width(Constants.ExerciseNameLabel.width)
            .height(Constants.contentHeight)
            .vCenter()
        
        resultLabel.pin
            .right()
            .after(of: exerciseNameLabel)
            .marginLeft(Constants.horizontalMargin)
            .height(Constants.contentHeight)
            .vCenter()
    }
    
    // MARK: - Setup
    
    func setup() {
        backgroundColor = Constants.backgroundColor
        circleImageView.tintColor = Constants.CounterLabel.uncheckedColor
        counterLabel.textAlignment = .center
        
        numberView.addSubviews(circleImageView, counterLabel)
        contentView.addSubviews(numberView, exerciseNameLabel, resultLabel)
    }
}

// MARK: - Constants

private extension TrainingTableViewCell {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        static let horizontalMargin: CGFloat = 20
        static let contentHeight: CGFloat = 40
        
        struct CounterLabel {
            static let checkedColor: UIColor = UIColor.UI.accent
            static let uncheckedColor: UIColor = UIColor.gray.withAlphaComponent(0.5)
            static let width: CGFloat = 40
        }
        
        struct ExerciseNameLabel {
            static let width: CGFloat = 200
        }
    }
}
