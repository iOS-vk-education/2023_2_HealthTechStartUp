//
//  SheetViewController.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import UIKit

final class SheetViewController: UIViewController {
    private let output: SheetViewOutput
    
    // MARK: - Init

    init(output: SheetViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(output: SheetViewOutput, type: SheetType) {
        self.init(output: output)
        
        let contentView: UIView?
        switch type {
        case .weightMeasurement(let weightMeasurementViewModel):
            contentView = WeightMeasureView(weight: weightMeasurementViewModel.weight)
        case .conditionChoice(let conditionChoiceViewModel):
            contentView = StateChoiceView(isGood: true)  // fix this
        case .heartRateVariability(let heartRateVariabilityViewModel):
            contentView = UIView()  // fix this
        case .camera(let cameraViewModel):
            contentView = CameraView()
        }
        guard let contentView else {
            // handle this case
            return
        }
                
        let view = SheetBaseView(contentView: contentView)
        self.view = view
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

private extension SheetViewController {
    
    // MARK: - Setup
    
    func setup() {
        view.backgroundColor = .systemMint
    }
}

// MARK: - ViewInput

extension SheetViewController: SheetViewInput {
}
