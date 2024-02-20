//
//  NotepadViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class NotepadViewController: UIViewController {
    private let output: NotepadViewOutput

    init(output: NotepadViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension NotepadViewController: NotepadViewInput {
}
