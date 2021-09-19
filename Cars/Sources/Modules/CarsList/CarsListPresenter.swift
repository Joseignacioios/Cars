//
//  CarsListPresenter.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import Foundation

protocol CarsListPresenterProtocol {
    func present(data: CarsList.Data)
    func present(isLoading: Bool)
    func present(error: Error)
}

final class CarsListPresenter: CarsListPresenterProtocol {
    typealias Data = CarsList.Data
    typealias CellViewModel = CarsList.ViewModel.Cell
    typealias AlertViewModel = CarsList.ViewModel.Alert
    
    private let mapper: CarMapperProtocol
    weak var viewController: CarsListViewControllerProtocol?
    
    init(mapper: CarMapperProtocol) {
        self.mapper = mapper
    }

    private func toViewModle(brand: Data.Brand) -> BrandViewModel {
        BrandViewModel(id: brand.id,
                       title: brand.title,
                       country: brand.country,
                       rating: brand.rating,
                       imageUrl: URL(string: brand.imageUrl ?? ""),
                       year: brand.year)
    }

    private func toViewModel(item: Data.Item) -> CellViewModel {
        switch item {
        case let .car(data):
            let viewModel = mapper.map(car: data, isHighlighted: false)
            return .car(viewModel: viewModel)
        case let .highlightedCar(data):
            let viewModel = mapper.map(car: data, isHighlighted: false)
            return .car(viewModel: viewModel)
        case let .brand(data):
            let viewModel = toViewModle(brand: data)
            return .brand(viewModel: viewModel)
        }
    }

    func present(data: CarsList.Data) {
        let cellViewModels = data.items.map(toViewModel)
        let viewModel = CarsList.ViewModel.data(cells: cellViewModels)
        DispatchQueue.main.async {
            self.viewController?.show(viewModel: viewModel)
        }
    }
    
    func present(error: Error) {
        let viewModel = AlertViewModel(
            title: "Something went wrong",
            message: error.localizedDescription,
            retry: "Retry",
            cancel: "Cancel"
        )
        DispatchQueue.main.async {
            self.viewController?.show(viewModel: .failure(alert: viewModel))
        }
    }
    
    func present(isLoading: Bool) {
        DispatchQueue.main.async {
            self.viewController?.show(isLoading: isLoading)
        }
    }

}
