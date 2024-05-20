//
//  ProgressViewController.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit
import SwiftUI

final class ProgressViewController: UIViewController {
    private let output: ProgressViewOutput

    private let healthView = UIHostingController(rootView: HealthView(healthService: HealthService.shared))
    init(output: ProgressViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        let swiftUIView = healthView.view!
        swiftUIView.backgroundColor = .none
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(healthView)
        view.addSubview(swiftUIView)
        
        NSLayoutConstraint.activate([
            swiftUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            swiftUIView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            swiftUIView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            swiftUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            swiftUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        healthView.didMove(toParent: self)
    }
}

extension ProgressViewController: ProgressViewInput {
}
