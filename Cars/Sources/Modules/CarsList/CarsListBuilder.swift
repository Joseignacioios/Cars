//
//  CarsListBuilder.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import UIKit

protocol CarsListBuilderProtocol {
    func build() -> UIViewController
}

final class CarsListBuilder: CarsListBuilderProtocol {
    private let service: CarSearchServiceProtocol

    init(service: CarSearchServiceProtocol) {
        self.service = service
    }

    func build() -> UIViewController {
        let presenter = CarsListPresenter()
        let interactor = CarsListInteractor(
            presenter: presenter,
            service: service
        )
        let viewController = CarsListViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
