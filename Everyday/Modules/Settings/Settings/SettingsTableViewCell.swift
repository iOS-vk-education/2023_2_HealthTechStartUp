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

    // MARK: - Interface
    
    func configure(with viewModel: SettingsTableViewCellModel) {
        cellImage.contentMode = .scaleAspectFit
        cellImage.image = viewModel.cellImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        cellTitle.attributedText = viewModel.cellTitle
    }

    // swiftlint:disable cyclomatic_complexity
    func setBackgroundColor(indexPath: IndexPath, cell: String) {
        switch cell {
        case "Profile":
            backgroundImageView.backgroundColor = .red
        case "Support":
            backgroundImageView.backgroundColor = Constants.accentColor
        case "General":
            switch indexPath.item {
            case 0:
                backgroundImageView.backgroundColor = .systemYellow
            case 1:
                backgroundImageView.backgroundColor = .gray
            case 2:
                backgroundImageView.backgroundColor = .systemGreen
            case 3:
                backgroundImageView.backgroundColor = .systemOrange
            case 4:
                backgroundImageView.backgroundColor = .purple
            default:
                backgroundImageView.backgroundColor = .gray
            }
        case "AboutApp":
            switch indexPath.item {
            case 0:
                backgroundImageView.backgroundColor = .systemBlue
            case 1:
                backgroundImageView.backgroundColor = .systemTeal
            case 2:
                backgroundImageView.backgroundColor = .systemBrown
            default:
                backgroundImageView.backgroundColor = .gray
            }
        case "AppleHealth":
            cellImage.image = UIImage(named: "AppleHealth")
            
        default:
            backgroundImageView.backgroundColor = .gray
        }
        
        // swiftlint:enable cyclomatic_complexity
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
