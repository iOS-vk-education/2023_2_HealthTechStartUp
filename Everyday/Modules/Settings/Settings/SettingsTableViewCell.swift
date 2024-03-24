//
//  SettingsTableViewCell.swift
//  Everyday
//
//  Created by Yaz on 02.03.2024.
//

import UIKit
import PinLayout

final class SettingsTableViewCell: UITableViewCell {
    static let reuseID = "SettingsTableViewCell"
    
    // MARK: - Private properties
    
    private let cellImage = UIImageView()
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
    
    func configure(with viewModel: SettingsTableViewCellModel) {
        cellImage.contentMode = .scaleAspectFit
        cellImage.image = viewModel.cellImage?.withTintColor(Constants.accentColor)
        cellTitle.attributedText = viewModel.cellTitle
    }
}

private extension SettingsTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        cellImage.pin
            .left(Constants.horizontalMargin)
            .vCenter()
            .width(Constants.cellImage.width)
            .height(Constants.cellImage.height)
        
        cellTitle.pin
            .left(to: cellImage.edge.right)
            .margin(Constants.horizontalMargin)
            .vCenter()
            .width(of: UITableViewCell())
            .height(Constants.contentHeight)
        
        contentView.pin
            .width(of: UITableViewCell())
    }
    
    // MARK: - Setup
    
    func setup() {
        contentView.addSubviews(cellImage, cellTitle)
    }
}

private extension SettingsTableViewCell {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.grayElement
        
        static let horizontalMargin: CGFloat = 10
        static let contentHeight: CGFloat = 20
        
        struct cellImage {
            static let width: CGFloat = 30
            static let height: CGFloat = 30
        }
        
        struct cellTitle {
            static let width: CGFloat = 200
        }
    }
}
