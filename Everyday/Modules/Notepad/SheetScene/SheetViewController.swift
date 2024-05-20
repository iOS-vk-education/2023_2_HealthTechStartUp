//
//  SheetViewController.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//
//

import UIKit
import PinLayout

final class SheetViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let contentView: UIView
    private let output: SheetViewOutput
    
    // MARK: - Init

    init(output: SheetViewOutput, contentView: UIView) {
        self.output = output
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
}

private extension SheetViewController {
    
    // MARK: - Layout
    
    func layout() {
        contentView.pin.all()
    }
    
    // MARK: - Setup
    
    func setup() {
        view.addSubviews(contentView)
    }
}

// MARK: - ViewInput

extension SheetViewController: SheetViewInput {
}

// MARK: - Constants

private extension SheetViewController {
    struct Constants {
        static let marginTop: CGFloat = 8
    }
}
