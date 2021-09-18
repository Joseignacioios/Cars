//
//  CarsInteractor.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

protocol CarsInteractorProtocol {
    func loadData()
    func didSelect(property id: Int)
}

final class MockCarsInteractor: CarsInteractorProtocol {
    private let presenter: CarsPresenterProtocol

    init(presenter: CarsPresenterProtocol) {
        self.presenter = presenter
    }

    func loadData() {}

    func didSelect(property id: Int) {}
}
