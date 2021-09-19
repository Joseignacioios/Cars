//
//  CarDetailBuilder.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

import UIKit

protocol CarDetailBuilderProtocol {
    func build(input: CarDetail.Input) -> UIViewController
}

final class CarDetailBuilder: CarDetailBuilderProtocol {
    private let mapper: CarMapperProtocol

    init(mapper: CarMapperProtocol) {
        self.mapper = mapper
    }

    func build(input: CarDetail.Input) -> UIViewController {
        let presenter = CarDetailPresenter(mapper: mapper)
        let interactor = CarDetailInteractor(
            data: CarDetail.Data(
                car: input.car,
                isHighlighted: input.isHighlighted
            ),
            presenter: presenter
        )
        let viewController = CarDetailViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}

