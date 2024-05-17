//
//  ProfileTableViewCellWithTitle.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//

import UIKit
import PinLayout

final class ProfileTableViewCellWithTitle: UITableViewCell {
    static let reuseID = "ProfileTableViewCellWithTitle"
    
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
        cellTitle.textAlignment = .center
        cellTitle.attributedText = viewModel
    }
}

private extension ProfileTableViewCellWithTitle {
    // MARK: - Layout
    
    func layout() {
        
        cellTitle.pin
            .width(Constants.Title.width)
            .height(Constants.contentHeight)
            .vCenter()
            .hCenter()
    }
    
    // MARK: - Setup
    
    func setup() {
        contentView.addSubview(cellTitle)
    }
}

private extension ProfileTableViewCellWithTitle {
    struct Constants {
        static let horizontalMargin: CGFloat = 10
        static let contentHeight: CGFloat = 20
        
        struct Title {
            static let width: CGFloat = 200
        }
    }
}
