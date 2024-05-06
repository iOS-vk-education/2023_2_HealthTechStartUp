//
//  TrainingTableViewCell.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit
import PinLayout

// MARK: - Protocols

protocol SwitchTableViewCellDelegate: AnyObject {
    func switchCell(_ cell: TrainingTableViewCell, with value: Bool)
}

class TrainingTableViewCell: UITableViewCell {
    static let reuseID = "TrainingTableViewCell"
    
    // MARK: - Private properties
    
    private let checkbox = UILabel()
    private let circleImageView = UIImageView()
    private let numberView = UIView()
    private let exerciseNameLabel = UILabel()
    private let resultLabel = UILabel()
    private let startButton = UIButton()
    
    // MARK: - Public properties
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

    func configure(with viewModel: TrainingTableViewCellViewModel, and index: Int, isDone: Bool) {
        exerciseNameLabel.attributedText = viewModel.title
        resultLabel.attributedText = viewModel.result
        startButton.setAttributedTitle(viewModel.startTitle, for: .normal)
        checkbox.attributedText = viewModel.number
        
        startButton.tag = index
        
        checkbox.text = String(index + 1)
        
        if isDone {
            circleImageView.image = viewModel.circleFilled
            circleImageView.tintColor = Constants.Checkbox.checkedColor
        } else {
            circleImageView.image = viewModel.circleFilled
            circleImageView.tintColor = Constants.Checkbox.uncheckedColor
        }
    }
    
    func updateResult(with result: String) {
        resultLabel.text = result
    }
    
    func showStartButton() {
        startButton.isHidden = false
    }
    
    func hideStartButton() {
        startButton.isHidden = true
    }
    
    func addStartButtonTarget(_ target: Any?, action: Selector) {
        startButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setStartButtonTag(_ tag: Int) {
        startButton.tag = tag
    }
    
    func disableCheckBox() {
        checkbox.isUserInteractionEnabled = false
    }
    
    func enableCheckBox() {
        checkbox.isUserInteractionEnabled = true
    }
    
    func checkCheckBox() {
        checkbox.textColor = Constants.Checkbox.checkedColor
    }
}

private extension TrainingTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        numberView.pin
            .left(Constants.horizontalMargin)
            .width(Constants.Checkbox.width)
            .height(Constants.contentHeight)
            .vCenter()
        
        circleImageView.pin
            .width(Constants.Checkbox.width)
            .height(Constants.contentHeight)
            .vCenter()
            .hCenter()
        
        checkbox.pin
            .width(Constants.Checkbox.width)
            .height(Constants.contentHeight)
            .vCenter()
            .hCenter()
        
        exerciseNameLabel.pin
            .after(of: checkbox)
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
        
        startButton.pin
            .right(Constants.horizontalMargin)
            .after(of: exerciseNameLabel)
            .marginLeft(Constants.horizontalMargin)
            .height(Constants.contentHeight)
            .vCenter()
    }
    
    // MARK: - Setup
    
    func setup() {
        startButton.backgroundColor = Constants.StartButton.backgroundColor
        startButton.layer.cornerRadius = Constants.StartButton.cornerRadius
        startButton.isHidden = true
        
        circleImageView.tintColor = Constants.Checkbox.uncheckedColor
        checkbox.textAlignment = .center
        
        numberView.addSubviews(circleImageView, checkbox)
        contentView.addSubviews(numberView, exerciseNameLabel, resultLabel, startButton)
    }
}

// MARK: - Constants

private extension TrainingTableViewCell {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        static let horizontalMargin: CGFloat = 20
        static let contentHeight: CGFloat = 40
        
        struct Checkbox {
            static let checkedColor: UIColor = UIColor.UI.accent
            static let uncheckedColor: UIColor = UIColor.gray.withAlphaComponent(0.5)
            static let width: CGFloat = 40
        }
        
        struct ExerciseNameLabel {
            static let width: CGFloat = 200
        }
        
        struct StartButton {
            static let backgroundColor: UIColor = UIColor.UI.accent
            static let cornerRadius: CGFloat = 16
        }
    }
}
