//
//  CatalogPresenter.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//  
//

import Foundation

final class CatalogPresenter {
    weak var view: CatalogViewInput?
    weak var moduleOutput: CatalogModuleOutput?
    
    private let router: CatalogRouterInput
    private let interactor: CatalogInteractorInput
    private var catalog: Catalog?
    
    init(router: CatalogRouterInput, interactor: CatalogInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CatalogPresenter: CatalogModuleInput {
    func setTrains(_ trains: [Train], _ type: String) {
        self.catalog = Catalog(title: type, trains: trains)
    }
}

extension CatalogPresenter: CatalogViewOutput {
    func configureCell(for train: Train, at indexPath: IndexPath) async {
        do {
            guard let image = try await StorageService.shared.getImage(path: train.image) else {
                throw URLError(.cannotDecodeContentData)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                let model = ExercisePreviewViewModel(title: train.title, level: train.level, image: image)
                self.view?.configureCell(with: model, and: indexPath)
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.view?.showAlert(with: .fetchingUserError(error: error))
            }
        }
    }
    
    func getTrains() -> [Train] {
        guard let catalog = catalog else {
            fatalError("как ты до сюда дошел ?")
        }
        
        return catalog.trains
    }
    
    func getCount() -> Int {
        guard let catalog = catalog else {
            return 0
        }
        
        return catalog.trains.count
    }
    
    func didLoadView() {
        guard let catalog = catalog else {
            return
        }
        
        let model = CatalogViewModel(title: catalog.title)
        view?.configure(with: model)
    }
}

extension CatalogPresenter: CatalogInteractorOutput {
}
