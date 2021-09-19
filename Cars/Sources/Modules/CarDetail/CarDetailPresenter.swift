//
//  CarDetailPresenter.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

protocol CarDetailPresenterProtocol: AnyObject {
    func present(data: CarDetail.Data)
}

final class CarDetailPresenter: CarDetailPresenterProtocol {
    weak var viewController: CarDetailViewControllerProtocol?
    private let mapper: CarMapperProtocol

    init(mapper: CarMapperProtocol) {
        self.mapper = mapper
    }

    func present(data: CarDetail.Data) {
        let carViewModel = mapper.map(car: data.car, isHighlighted: data.isHighlighted)
        let viewModel = CarDetail.ViewModel(car: carViewModel)
        viewController?.show(viewModel: viewModel)
    }
}
