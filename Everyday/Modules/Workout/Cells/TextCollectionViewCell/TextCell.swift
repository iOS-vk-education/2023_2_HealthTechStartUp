//
//  TextCell.swift
//  workout
//
//  Created by Михаил on 30.03.2024.
//

import UIKit
import PinLayout

final class TextCell: UICollectionViewCell {
    // MARK: - private properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "SpaceGray")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
           
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.pin.all()
        
        titleLabel.pin
            .top(10)
            .bottom(10)
            .left(10)
            .right(10)
    }
    
    // MARK: - actions
    
    private func setUp() {
        contentView.addSubview(containerView)
        contentView.addSubview(titleLabel)
    }
    
    func setText(_ text: String, isActive: Bool) {
        titleLabel.text = text
        titleLabel.font = isActive ? UIFont.boldSystemFont(ofSize: 28) : UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = isActive ? UIColor(named: "SpaceGray") : .gray
    }
    
    func setText(isActive: Bool) {
        titleLabel.font = isActive ? UIFont.boldSystemFont(ofSize: 28) : UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = isActive ? UIColor(named: "SpaceGray") : .gray
    }
}
