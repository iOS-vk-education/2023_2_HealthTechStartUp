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
    
    private let backgroundImageView = UIView()
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

    // MARK: - Actions
    
    func configure(with viewModel: SettingsTableViewCellModel) {
        cellImage.contentMode = .scaleAspectFit
        cellImage.image = viewModel.cellImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        cellTitle.attributedText = viewModel.cellTitle
    }

    func setBackgroundColor(indexPath: IndexPath, cell: String) {
        let color: UIColor
        
        switch cell {
        case "Profile":
            color = .red
        case "Support":
            color = Constants.accentColor
        case "General":
            color = generalColor(for: indexPath.item)
        case "AboutApp":
            color = aboutAppColor(for: indexPath.item)
        case "AppleHealth":
            cellImage.image = UIImage(named: "AppleHealth")
            color = .systemBackground
        default:
            color = .gray
        }
        backgroundImageView.backgroundColor = color
    }

    private func generalColor(for index: Int) -> UIColor {
        switch index {
        case 0: return .systemYellow
        case 1: return .gray
        case 2: return .systemGreen
        case 3: return .systemOrange
        case 4: return .purple
        default: return .gray
        }
    }

    private func aboutAppColor(for index: Int) -> UIColor {
        switch index {
        case 0: return .systemBlue
        case 1: return .systemTeal
        case 2: return .systemBrown
        default: return .gray
        }
    }
}

private extension SettingsTableViewCell {
    
    // MARK: - Layout
    
    func layout() {
        backgroundImageView.pin
           .left(Constants.horizontalMargin)
           .vCenter()
           .width(Constants.backgroundImage.size.width)
           .height(Constants.backgroundImage.size.height)
               
       cellImage.pin
           .center()
           .width(Constants.cellImage.size.width)
           .height(Constants.cellImage.size.height)
        
        cellTitle.pin
            .after(of: backgroundImageView)
            .margin(Constants.horizontalMargin)
            .vCenter()
            .width(of: UITableViewCell())
            .height(Constants.contentHeight)
        
        contentView.pin
            .width(of: UITableViewCell())
    }
    
    // MARK: - Setup
    
    func setup() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(cellImage)
        contentView.addSubview(cellTitle)
                
        backgroundImageView.layer.cornerRadius = Constants.backgroundImage.cornerRadius
        backgroundImageView.clipsToBounds = true
    }
}

private extension SettingsTableViewCell {
    struct Constants {
        static let backgroundColor: UIColor = .background
        static let accentColor: UIColor = UIColor.UI.accent
        static let textColor: UIColor = UIColor.Text.grayElement
        
        static let horizontalMargin: CGFloat = 10
        static let contentHeight: CGFloat = 20
        
        struct backgroundImage {
            static let size: CGSize = CGSize(width: 30, height: 30)
            static let cornerRadius: CGFloat = 8
        }
        
        struct cellImage {
            static let size: CGSize = CGSize(width: 26, height: 26)
        }
        
        struct cellTitle {
            static let width: CGFloat = 200
        }
    }
}
