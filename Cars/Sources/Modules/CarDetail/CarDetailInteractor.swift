//
//  CarDetailInteractor.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

import Foundation

protocol CarDetailInteractorProtocol {
    func loadData()
}

final class CarDetailInteractor: CarDetailInteractorProtocol {
    private let data: CarDetail.Data
    private let presenter: CarDetailPresenterProtocol

    init(
        data: CarDetail.Data,
        presenter: CarDetailPresenterProtocol
    ) {
        self.data = data
        self.presenter = presenter
    }

    func loadData() {
        presenter.present(data: data)
    }
}
