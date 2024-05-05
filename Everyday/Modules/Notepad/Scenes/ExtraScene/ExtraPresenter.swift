//
//  ExtraPresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

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
    
    // MARK: - Init
    
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
        guard index != 2 else {  // because heart rate not implemented
            return
        }
        router.showView(viewTypes[index], with: data[index])
    }
    
    func didTapFinishButton() {
        var image: UIImage?
        var condition: Int?
        var weight: Double?
        
        for element in data {
            switch element {
            case .camera(let model):
                image = model.image
            case .conditionChoice(let model):
                condition = Condition.allCases.firstIndex { $0 == model.condition }
            case .heartRateVariability(let model):
                continue
            case .weightMeasurement(let model):
                weight = model.weight
            }
        }
        
        progress.extra = ExtraModel(
            image: image,
            condition: condition,
            weight: weight
        )
        
        interactor.saveProgress(progress)
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
    func didPostData() {
        router.openNotepad()
    }
    
    func didStartLoading() {
        view?.showLoadingView()
    }
    
    func didEndLoading() {
        view?.dismissLoadingView()
    }
}
