//
//  HealthTableViewCell.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//

import UIKit
import PinLayout

final class HealthTableViewCellButton: UITableViewCell {
    static let reuseID = "HealthTableViewCellButton"
    
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
    
    func configure(with title: NSAttributedString) {
        cellTitle.attributedText = title
        cellTitle.textAlignment = .center
    }
}

private extension HealthTableViewCellButton {
    // MARK: - Layout
    
    func layout() {
        cellTitle.pin
            .hCenter()
            .vCenter()
            .width(Constants.cellTitle.width)
            .height(Constants.contentHeight)
    }
    
    // MARK: - Setup
    
    func setup() {
        contentView.addSubviews(cellTitle)
    }
}

private extension HealthTableViewCellButton {
    struct Constants {
        static let horizontalMargin: CGFloat = 10
        static let contentHeight: CGFloat = 24
        
        struct cellTitle {
            static let width: CGFloat = 230
        }
        
        struct cellValue {
            static let width: CGFloat = 60
        }
    }
}
