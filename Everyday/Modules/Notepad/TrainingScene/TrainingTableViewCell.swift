//
//  TrainingTableViewCell.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit
import PinLayout
import M13Checkbox

// MARK: - Protocols

protocol SwitchTableViewCellDelegate: AnyObject {
    func switchCell(_ cell: TrainingTableViewCell, with value: Bool)
}

class TrainingTableViewCell: UITableViewCell {
    static let reuseID = "TrainingTableViewCell"
    
    // MARK: - Private properties
    
    private let checkbox = M13Checkbox()
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

    func configure(with exercise: Exercise, and index: Int) {
        exerciseNameLabel.text = exercise.name
        resultLabel.text = exercise.result
        startButton.tag = index
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
    
    func uncheckCheckBox() {
        checkbox.setCheckState(.unchecked, animated: true)
    }
    
    func checkCheckBox() {
        checkbox.setCheckState(.checked, animated: true)
    }
}

private extension TrainingTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        checkbox.pin
            .left(20)
            .vCenter()
            .width(40)
            .height(40)
        
        exerciseNameLabel.pin
            .after(of: checkbox)
            .marginLeft(20)
            .width(200)
            .height(40)
            .vCenter()
        
        resultLabel.pin
            .right()
            .after(of: exerciseNameLabel)
            .marginLeft(20)
            .height(40)
            .vCenter()
        
        startButton.pin
            .right(20)
            .after(of: exerciseNameLabel)
            .marginLeft(20)
            .height(40)
            .vCenter()
    }
    
    // MARK: - Setup
    
    func setup() {
        checkbox.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        checkbox.stateChangeAnimation = .bounce(.fill)
        checkbox.setCheckState(.unchecked, animated: true)
        
        startButton.setTitle("Начать", for: .normal)
        startButton.backgroundColor = .systemMint
        startButton.layer.cornerRadius = 16
        startButton.isHidden = true
        
        contentView.addSubviews(checkbox, exerciseNameLabel, resultLabel, startButton)
    }
    
    // MARK: - Actions
    
    @objc
    func switchValueChanged(_ sender: M13Checkbox) {
        var value = false
        switch sender.checkState {
        case .unchecked:
            value = false
        case .checked:
            value = true
        case .mixed:
            value = false
        }
        delegate?.switchCell(self, with: value)
    }
}
