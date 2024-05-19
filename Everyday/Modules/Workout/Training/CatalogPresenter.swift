//
//  CatalogPresenter.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//  
//

import UIKit

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
    func didSelectCell(train: Train, image: UIImage) {
        router.openCell(train: train, image: image)
    }
    
    func configureCell(for train: Train, at indexPath: IndexPath) async throws -> ExercisePreviewViewModel {
        guard let image = try? await StorageService.shared.getImage(path: train.image) else {
            throw NSError(domain: "ImageLoadError", code: -1, userInfo: nil)
        }

        let model = ExercisePreviewViewModel(title: train.title, level: train.level, image: image)
        return model
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
