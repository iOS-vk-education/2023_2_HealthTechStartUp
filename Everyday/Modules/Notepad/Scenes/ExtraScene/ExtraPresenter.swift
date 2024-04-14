//
//  ExtraPresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

final class ExtraPresenter {
    weak var view: ExtraViewInput?
    weak var moduleOutput: ExtraModuleOutput?
    
    private let router: ExtraRouterInput
    private let interactor: ExtraInteractorInput
    
    private var viewTypes: [ExtraViewType] = []
    private var switchStates: [Bool] = []
    
    init(router: ExtraRouterInput, interactor: ExtraInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ExtraPresenter: ExtraModuleInput {
}

extension ExtraPresenter: ExtraViewOutput {
    func didLoadView() {
        let viewModel = ExtraViewModel()
        view?.configure(with: viewModel)
        viewTypes = ExtraViewType.allCases
        switchStates = [Bool](repeating: false, 
                              count: viewTypes.count)
        view?.reloadData()
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        viewTypes.count
    }
    
    func getViewType(at index: Int) -> ExtraViewType {
        viewTypes[index]
    }
    
    func getSwitchState(at index: Int) -> Bool {
        switchStates[index]
    }
    
    func didSelectRowAt(index: Int) {
        router.showView(with: viewTypes[index])
    }
    
    func didTapFinishButton() {
        router.openNotepad()
    }
}

extension ExtraPresenter: ExtraInteractorOutput {
}
