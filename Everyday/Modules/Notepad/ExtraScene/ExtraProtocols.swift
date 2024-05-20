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
    func showLoadingView()
    func dismissLoadingView()
}

protocol ExtraViewOutput: AnyObject {
    func didLoadView()
    func numberOfRowsInSection(_ section: Int) -> Int
    func getViewType(at index: Int) -> SheetType
    func getSwitchState(at index: Int) -> Bool
    func didSelectRowAt(index: Int)
    func didTapFinishButton()
}

protocol ExtraInteractorInput: AnyObject {
    func saveProgress(_ progress: WorkoutProgress)
}

protocol ExtraInteractorOutput: AnyObject {
    func didPostData()
    func didStartLoading()
    func didEndLoading()
}

protocol ExtraRouterInput: AnyObject {
    func showView(of type: SheetType)
    func openNotepad()
}
