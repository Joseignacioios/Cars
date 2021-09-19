//
//  CarsListBuilder.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import UIKit

protocol CarsListBuilderProtocol: AnyObject {
    func build() -> UIViewController
}

final class CarsListBuilder: CarsListBuilderProtocol {
    private let service: CarSearchServiceProtocol
    private let mapper: CarMapperProtocol
    private let carDetailsBuilder: CarDetailBuilderProtocol

    init(service: CarSearchServiceProtocol,
         mapper: CarMapperProtocol,
         carDetailsBuilder: CarDetailBuilderProtocol) {
        self.service = service
        self.mapper = mapper
        self.carDetailsBuilder = carDetailsBuilder
    }

    func build() -> UIViewController {
        let router = CarsListRouter(carDetailsBuilder: carDetailsBuilder)
        let presenter = CarsListPresenter(mapper: mapper)

        let interactor = CarsListInteractor(
            presenter: presenter,
            service: service,
            router: router
        )
        let viewController = CarsListViewController(interactor: interactor)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
