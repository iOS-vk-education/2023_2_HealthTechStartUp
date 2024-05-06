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
    
    private var workoutProgress: WorkoutProgress

    private var switchStates: [Bool] = []
    private var data: [SheetType] = []
    
    private var extra: [SheetType] = []
    
    init(router: ExtraRouterInput, interactor: ExtraInteractorInput, workout: Workout) {
        self.router = router
        self.interactor = interactor
        self.workoutProgress = WorkoutProgress(workout: workout)
    }
}

extension ExtraPresenter: ExtraModuleInput {
}

private extension ExtraPresenter {
    
    // MARK: - Init
    
    func initProperties() {
        initData()
        initSwitchStates()
    }
    
    func initSwitchStates() {
        switchStates = [Bool](repeating: false, count: data.count)
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
        data.count
    }
    
    func getViewType(at index: Int) -> SheetType {
        data[index]
    }
    
    func getSwitchState(at index: Int) -> Bool {
        switchStates[index]
    }
    
    func didSelectRowAt(index: Int) {
        guard index != 2 else {  // because heart rate not implemented
            return
        }
        router.showView(of: data[index])
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
                condition = model.condition?.rawValue
            case .heartRateVariability:
                continue
            case .weightMeasurement(let model):
                weight = model.weight
            }
        }
        
        if image != nil || condition != nil || weight != nil {
            workoutProgress.extra = ExtraModel(
                image: image,
                condition: condition,
                weight: weight
            )
        }
        
        interactor.saveProgress(workoutProgress)
    }
}

extension ExtraPresenter: SheetModuleOutput {
    func setResult(_ result: SheetType, at index: Int) {
        data[index] = result
        switch result {
        case .camera(let model):
            switchStates[index] = model.image != nil
        case .conditionChoice(let model):
            switchStates[index] = model.condition != nil
        case .heartRateVariability(let model):
            switchStates[index] = model.heartRateVariability != nil
        case .weightMeasurement(let model):
            switchStates[index] = model.weight != nil
        }
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
