//
//  SettingsViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class SettingsViewController: UIViewController {
    private let output: SettingsViewOutput

    init(output: SettingsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension SettingsViewController: SettingsViewInput {
}
