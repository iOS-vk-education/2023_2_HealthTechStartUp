//
//  SheetContainer.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import UIKit

final class SheetContainer {
    let input: SheetModuleInput
    let viewController: UIViewController
    private(set) weak var router: SheetRouterInput!
    
    class func assemble(with context: SheetContext) -> SheetContainer {
        let router = SheetRouter()
        let interactor = SheetInteractor()
        let presenter = SheetPresenter(router: router, interactor: interactor, moduleType: context.type)
        
        var contentView = UIView()
        switch context.type {
        case .camera(let cameraModel):
            contentView = CameraView(image: cameraModel.image, output: presenter)
            presenter.cameraView = contentView as? CameraView
        case .conditionChoice(let conditionChoiceViewModel):
            contentView = ConditionChoiceView(condition: conditionChoiceViewModel.condition, output: presenter)
            presenter.conditionChoiceView = contentView as? ConditionChoiceView
        case .heartRateVariability:
            contentView = EmptyStateView()
        case .weightMeasurement(let weightMeasurementViewModel):
            contentView = WeightMeasurementView(weight: weightMeasurementViewModel.weight, output: presenter)
            presenter.weightMeasurementView = contentView as? WeightMeasurementView
            presenter.didLoadWeightMeasurementView()
        }
        
        let viewController = SheetViewController(output: presenter, contentView: contentView)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return SheetContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SheetModuleInput, router: SheetRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SheetContext {
    weak var moduleOutput: SheetModuleOutput?
    let type: SheetType
}
