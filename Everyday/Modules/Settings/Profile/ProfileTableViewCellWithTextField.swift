//
//  ProfileTableViewCellWithTextField.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//

import UIKit
import PinLayout

final class ProfileTableViewCellWithTextField: UITableViewCell {
    static let reuseID = "ProfileTableViewCellWithTextField"
    
    // MARK: - Properties
    
    private let textField = UITextField()
    
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
        textField.autocapitalizationType = .none
        textField.attributedText = viewModel
    }
    
    func setDelegate(with delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }
}

private extension ProfileTableViewCellWithTextField {
    // MARK: - Layout
    
    func layout() {
        
        textField.pin
            .top()
            .horizontally()
            .bottom()
            .marginLeft(Constants.TextField.marginLeft)
    }
    
    // MARK: - Setup
    
    func setup() {
        contentView.addSubview(textField)
    }
}

private extension ProfileTableViewCellWithTextField {
    struct Constants {
        static let horizontalMargin: CGFloat = 10
        static let contentHeight: CGFloat = 20
        
        struct TextField {
            static let marginLeft: CGFloat = 30
        }
    }
}
