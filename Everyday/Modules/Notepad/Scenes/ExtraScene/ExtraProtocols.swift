//
//  ExtraProtocols.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

protocol ExtraModuleInput {
    var moduleOutput: ExtraModuleOutput? { get }
}

protocol ExtraModuleOutput: AnyObject {
}

protocol ExtraViewInput: AnyObject {
    func configure(with viewModel: ExtraViewModel)
    func reloadData()
}

protocol ExtraViewOutput: AnyObject {
    func didLoadView()
    func numberOfRowsInSection(_ section: Int) -> Int
    func getViewType(at index: Int) -> ExtraViewType
    func getSwitchState(at index: Int) -> Bool
    func didSelectRowAt(index: Int)
    func didTapFinishButton()
}

protocol ExtraInteractorInput: AnyObject {
}

protocol ExtraInteractorOutput: AnyObject {
}

protocol ExtraRouterInput: AnyObject {
    func showView(with type: ExtraViewType)
    func openNotepad()
}
