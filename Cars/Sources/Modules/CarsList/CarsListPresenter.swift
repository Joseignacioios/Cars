//
//  CarsListPresenter.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import Foundation

protocol CarsListPresenterProtocol {
    func present(data: CarsList.Data)
    func present(error: Error)
}

final class CarsListPresenter: CarsListPresenterProtocol {
    typealias Data = CarsList.Data
    typealias CellViewModel = CarsList.ViewModel.Cell
    typealias AlertViewModel = CarsList.ViewModel.Alert
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()

    private let measurementFormatter: MeasurementFormatter = {
        let measurementFormatter = MeasurementFormatter()

        return measurementFormatter
    }()

    weak var viewController: CarsListViewControllerProtocol?
    
    private func pretify(days: Int) -> String {
        let formatString: String = NSLocalizedString("REMAINING_DAY_PATTERN", comment: "")
        let resultString = String.localizedStringWithFormat(formatString, days)
        return resultString
    }

    private func pretify(double: Double) -> String {
        let number = NSNumber(value: double)
        return numberFormatter.string(from: number) ?? "\(double)"
    }
    
    private func toViewModle(car: Data.Car, isHighlighted: Bool) -> CarViewModel {
        CarViewModel(id: car.id,
                     title: car.title,
                     imageUrl: URL(string: car.imageUrl ?? ""),
                     isPremium: isHighlighted,
                     horsePowers: String(format: NSLocalizedString("CAR_LIST_HORSEPOWERS", comment: ""), "\(car.horsePowers)"),
                     brand: car.brand,
                     price: String(format: NSLocalizedString("CAR_LIST_PRICE", comment: ""), "\(car.price)"),
                     engineVolume: String(format: NSLocalizedString("CAR_LIST_ENGINEVOLUME", comment: ""), "\(pretify(double:car.engineVolume))"),
                     mileage: String(format: NSLocalizedString("CAR_LIST_MILEAGE", comment: ""), "\(car.mileage)"),
                     year: car.year,
                     daysPosted: pretify(days: car.daysPosted)
        )
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
            let viewModel = toViewModle(car: data, isHighlighted: false)
            return .car(viewModel: viewModel)
        case let .highlightedCar(data):
            let viewModel = toViewModle(car: data, isHighlighted: true)
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
}
