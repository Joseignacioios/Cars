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
    func build() -> UIViewController {
        let presenter = CarsPresenter()
        let interactor = MockCarsInteractor(presenter: presenter)
        let viewController = CarsViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
