//
//  CarsListInteractor.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

protocol CarsListInteractorProtocol {
    func loadData()
    func request(request: CarsList.Request)

}

final class CarsListInteractor: CarsListInteractorProtocol {
    private let presenter: CarsListPresenterProtocol
    private let service: CarSearchServiceProtocol

    init(presenter: CarsListPresenterProtocol, service: CarSearchServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }

    func loadData() {
        service.fetch(request: CarSearch.Request()) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter.present(data: response)
            case let .failure(error):
                self?.presenter.present(error: error)

            }
            print(result)
        }
    }
    
    func request(request: CarsList.Request) {
        switch request {
        case let .car(id): ()
        case .reload:
            loadData()
        }
}
