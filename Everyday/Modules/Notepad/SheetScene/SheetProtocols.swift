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
    func setResult(_ result: SheetType)
}

protocol SheetViewInput: AnyObject {
}

protocol SheetViewOutput: AnyObject {
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
