//
//  DateAndTimeTableViewCell.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//

import UIKit
import PinLayout

final class DateAndTimeTableViewCell: UITableViewCell {
    static let reuseID = "DateAndTimeTableViewCell"
    
    // MARK: - Private properties
    
    private let cellTitle = UILabel()
    
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
    
    func configure(with viewModel: NSAttributedString) {
        cellTitle.attributedText = viewModel
    }
}

private extension DateAndTimeTableViewCell {
    // MARK: - Layout
    
    func layout() {
        cellTitle.pin
            .left(Constants.horizontalMargin)
            .vCenter()
            .width(Constants.cellTitle.width)
            .height(Constants.contentHeight)
    }
    
    // MARK: - Setup
    
    func setup() {
        contentView.addSubview(cellTitle)
    }
}

private extension DateAndTimeTableViewCell {
    struct Constants {
        static let horizontalMargin: CGFloat = 10
        static let contentHeight: CGFloat = 20

        struct cellTitle {
            static let width: CGFloat = 200
        }
    }
}
