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
    func setResult(_ result: SheetType, at index: Int)
}

protocol SheetViewInput: AnyObject {
}

protocol SheetViewOutput: AnyObject {
    func didLoadView()
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
