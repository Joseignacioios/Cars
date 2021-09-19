//
//  CarsListRouter.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

import UIKit

protocol CarsListRouterProtocol {
    func routeToDetails(car: CarSearch.Response.Car, isHighlihted: Bool)
}

final class CarsListRouter: CarsListRouterProtocol {
    private let carDetailsBuilder: CarDetailBuilderProtocol
    weak var viewController: UIViewController?

    init(carDetailsBuilder: CarDetailBuilderProtocol) {
        self.carDetailsBuilder = carDetailsBuilder
    }

    func routeToDetails(car: CarSearch.Response.Car, isHighlihted: Bool) {
        guard let navigationController = viewController?.navigationController else { return }
        let details = carDetailsBuilder.build(input: CarDetail.Input(car: car, isHighlighted: isHighlihted))
        navigationController.pushViewController(details, animated: true)
    }
}
