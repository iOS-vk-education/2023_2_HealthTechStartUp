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
    
    private var progress = WorkoutProgress()
    private var viewTypes: [ExtraViewType] = []
    private var switchStates: [Bool] = []
    private var data: [SheetType] = []
    
    init(router: ExtraRouterInput, interactor: ExtraInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ExtraPresenter: ExtraModuleInput {
}

private extension ExtraPresenter {
    
    // MARK: - Helpers
    
    func initProperties() {
        initViewTypes()
        initSwitchStates()
        initData()
    }
    
    func initViewTypes() {
        viewTypes = ExtraViewType.allCases
    }
    
    func initSwitchStates() {
        switchStates = [Bool](repeating: false, count: viewTypes.count)
    }
    
    func initData() {
        data = [
            .camera(model: .init()),
            .conditionChoice(model: .init()),
            .heartRateVariability(model: .init()),
            .weightMeasurement(model: .init())
        ]
    }
}

extension ExtraPresenter: ExtraViewOutput {
    func didLoadView() {
        initProperties()
        let viewModel = ExtraViewModel()
        view?.configure(with: viewModel)
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
        router.showView(viewTypes[index], with: data[index])
    }
    
    func didTapFinishButton() {
//        interactor.saveProgress(progress)
    }
}

extension ExtraPresenter: SheetModuleOutput {
    func setResult(_ result: SheetType, at index: Int) {
        print("[DEBUG] old data: \(data[index])")
        data[index] = result
        print("[DEBUG] new data: \(data[index])")
        switchStates[index] = true
        view?.reloadData()
    }
}

extension ExtraPresenter: ExtraInteractorOutput {
    func didPostData(_ result: Bool) {
        if result {
            router.openNotepad()
        } else {
            print("[DEBUG] didPostData faillure")
        }
    }
    
    func didStartLoading() {
        view?.showLoadingView()
    }
    
    func didEndLoading() {
        view?.dismissLoadingView()
    }
}
