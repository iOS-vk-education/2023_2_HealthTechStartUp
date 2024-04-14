//
//  SheetProtocols.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import Foundation

protocol SheetModuleInput {
    var moduleOutput: SheetModuleOutput? { get }
}

protocol SheetModuleOutput: AnyObject {
}

protocol SheetViewInput: AnyObject {
    func configure(with viewModel: SheetViewModel)
}

protocol SheetViewOutput: AnyObject {
    func didLoadView()
    func didTapCloseButton()
    func didTapSaveButton()
}

protocol SheetWeightViewOutput: AnyObject {
}

protocol SheetStateViewOutput: AnyObject {
}

protocol SheetInteractorInput: AnyObject {
}

protocol SheetInteractorOutput: AnyObject {
}

protocol SheetRouterInput: AnyObject {
    func dismissSheet()
}
