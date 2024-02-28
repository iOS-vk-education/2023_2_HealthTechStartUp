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

    func configure(with exercise: Exercise) {
        exerciseNameLabel.text = exercise.name
        resultTextField.text = exercise.result
    }
}

private extension ResultsTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        exerciseNameLabel.pin
            .left(20)
            .vCenter()
            .width(200)
            .height(40)
        
        plusButton.pin
            .vCenter()
            .right(20)
            .width(20)
            .height(20)
        
        resultTextField.pin
            .vCenter()
            .before(of: plusButton)
            .width(40)
            .height(20)
        
        minusButton.pin
            .vCenter()
            .before(of: resultTextField)
            .width(20)
            .height(20)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupMinusButton()
        setupPlusButton()
        setupResultTextField()
        
        contentView.addSubviews(exerciseNameLabel, plusButton, resultTextField, minusButton)
    }
    
    func setupMinusButton() {
        let minusButtonImage = UIImage(systemName: "minus")
        minusButton.setImage(minusButtonImage, for: .normal)
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    func setupPlusButton() {
        let plusButtonImage = UIImage(systemName: "plus")
        plusButton.setImage(plusButtonImage, for: .normal)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    }
    
    func setupResultTextField() {
        resultTextField.backgroundColor = .secondaryLabel
        resultTextField.textAlignment = .center
    }
    
    // MARK: - Actions
    
    @objc
    func didTapMinusButton() {
        guard
            let resultText = resultTextField.text,
            let result = Int(resultText)
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
}
