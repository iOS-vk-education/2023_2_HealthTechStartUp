//
//  ResultsTableViewCell.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit
import PinLayout

class ResultsTableViewCell: UITableViewCell {
    static let reuseID = "ResultsTableViewCell"
    
    // MARK: - Private properties
    
    private let exerciseNameLabel = UILabel()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let resultTextField = UITextField()
    
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
        super.layoutSubviews()
        
        layout()
    }
    
    // MARK: - Interface

    func configure(with viewModel: ResultsTableViewCellViewModel) {
        exerciseNameLabel.attributedText = viewModel.exerciseName
        resultTextField.attributedText = viewModel.result
        minusButton.setImage(viewModel.minusImage, for: .normal)
        plusButton.setImage(viewModel.plusImage, for: .normal)
    }
}

private extension ResultsTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        exerciseNameLabel.pin
            .left(Constants.horizontalMargin)
            .width(Constants.ExerciseNameLabel.width)
            .height(Constants.ExerciseNameLabel.height)
            .vCenter()
        
        plusButton.pin
            .right(Constants.horizontalMargin)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
            .vCenter()
        
        resultTextField.pin
            .before(of: plusButton)
            .width(Constants.ResultTextField.width)
            .height(Constants.ResultTextField.height)
            .vCenter()
        
        minusButton.pin
            .before(of: resultTextField)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
            .vCenter()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupMinusButton()
        setupPlusButton()
        setupResultTextField()
        
        contentView.addSubviews(exerciseNameLabel, plusButton, resultTextField, minusButton)
    }
    
    func setupView() {
        contentView.backgroundColor = Constants.backgroundColor
    }
    
    func setupMinusButton() {
        minusButton.tintColor = Constants.Button.tintColor
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    func setupPlusButton() {
        plusButton.tintColor = Constants.Button.tintColor
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    }
    
    func setupResultTextField() {
        resultTextField.backgroundColor = .clear
        resultTextField.textColor = Constants.ResultTextField.textColor
        resultTextField.textAlignment = .center
        resultTextField.keyboardType = .numberPad
        resultTextField.addTarget(self, action: #selector(didEndEditingTextField), for: .editingDidEnd)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapMinusButton() {
        guard
            let resultText = resultTextField.text,
            let result = Int(resultText),
            result > 0
        else {
            return
        }
        
        resultTextField.text = String(result - 1)
    }
    
    @objc
    func didTapPlusButton() {
        guard
            let resultText = resultTextField.text,
            let result = Int(resultText)
        else {
            return
        }
        
        resultTextField.text = String(result + 1)
    }
    
    @objc
    func didEndEditingTextField() {
        guard let resultText = resultTextField.text else {
            return
        }
        
        if resultText.isEmpty || !resultText.isNumber || Int(resultText) ?? 0 < 0 {
            resultTextField.text = "0"
        }
    }
}

// MARK: - Constants

private extension ResultsTableViewCell {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        
        static let horizontalMargin: CGFloat = 20
        
        struct ExerciseNameLabel {
            static let width: CGFloat = 200
            static let height: CGFloat = 40
        }
        
        struct ResultTextField {
            static let textColor: UIColor = UIColor.Text.primary
            static let width: CGFloat = 50
            static let height: CGFloat = 20
        }
        
        struct Button {
            static let tintColor: UIColor = UIColor.Text.primary
            static let width: CGFloat = 20
            static let height: CGFloat = 20
        }
    }
}
