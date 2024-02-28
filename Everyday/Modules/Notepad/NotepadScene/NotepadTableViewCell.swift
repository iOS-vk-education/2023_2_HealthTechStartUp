//
//  NotepadTableViewCell.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import UIKit
import PinLayout

class NotepadTableViewCell: UITableViewCell {
    static let reuseID = "NotepadTableViewCell"
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    private let resultLabel = UILabel()
    
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
    
    func configure(with exercise: Exercise) {
        titleLabel.text = exercise.name
        resultLabel.text = exercise.result
    }
}

private extension NotepadTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        titleLabel.pin
            .left(10)
            .vCenter()
            .width(200)
            .height(20)
        
        resultLabel.pin
            .right(10)
            .vCenter()
            .width(100)
            .height(20)
    }
    
    // MARK: - Setup
    
    func setup() {
        resultLabel.textAlignment = .center
        
        contentView.addSubviews(titleLabel, resultLabel)
    }
}
