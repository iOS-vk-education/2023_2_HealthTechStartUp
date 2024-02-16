//
//  ProgressViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class ProgressViewController: UIViewController {
    private let output: ProgressViewOutput

    init(output: ProgressViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .red
        super.viewDidLoad()
    }
}

extension ProgressViewController: ProgressViewInput {
}
