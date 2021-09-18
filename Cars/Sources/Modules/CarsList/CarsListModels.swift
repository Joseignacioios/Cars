//
//  CarsListModels.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

enum CarsList {
    enum Request {
        case car(id: Int)
        case reload
    }

    typealias Data = CarSearch.Response

    enum ViewModel {
        case data(cells: [Cell])
        case failure(alert: Alert)
    }
}

extension CarsList.ViewModel {
    enum Cell {
        case car(viewModel: CarViewModel)
        case brand(viewModel: BrandViewModel)
    }
}

extension CarsList.ViewModel {
    struct Alert {
        let title: String
        let message: String
        let retry: String
        let cancel: String
    }
}
