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
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: - Interface
    
    func configure(with viewModel: NotepadTableViewCellViewModel) {
        titleLabel.attributedText = viewModel.title
        resultLabel.attributedText = viewModel.result
    }
}

private extension NotepadTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        titleLabel.pin
            .left(Constants.horizontalMargin)
            .vCenter()
            .width(Constants.TitleLabel.width)
            .height(Constants.contentHeight)
        
        resultLabel.pin
            .right(Constants.horizontalMargin)
            .vCenter()
            .width(Constants.ResultLabel.width)
            .height(Constants.contentHeight)
    }
    
    // MARK: - Setup
    
    func setup() {
        resultLabel.textAlignment = .center
        
        contentView.addSubviews(titleLabel, resultLabel)
    }
}

// MARK: - Constants

private extension NotepadTableViewCell {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.UI.accentLight
        
        static let horizontalMargin: CGFloat = 10
        static let contentHeight: CGFloat = 20
        
        struct TitleLabel {
            static let width: CGFloat = 200
        }
        
        struct ResultLabel {
            static let width: CGFloat = 100
        }
    }
}
