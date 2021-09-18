//
//  CarsListModels.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

enum CarsList {
    enum Request {
        case car(id: Int)
    }

    typealias Data = CarSearch.Response

    struct ViewModel {
        let cells: [Cell]
    }
}

extension CarsList.ViewModel {
    enum Cell {
        case car(viewModel: CarViewModel)
        case brand(viewModel: BrandViewModel)
    }
}
