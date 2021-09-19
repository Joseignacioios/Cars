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
    private let router: CarsListRouterProtocol
    private var items = [Int: (data: CarsList.Data.Car, isHighlighted: Bool)]()
    
    init(presenter: CarsListPresenterProtocol,
         service: CarSearchServiceProtocol,
         router: CarsListRouterProtocol) {
        self.presenter = presenter
        self.service = service
        self.router = router
    }
    
    private func buffer(_ response: CarSearch.Response) {
        response.items
            .compactMap { item -> (CarsList.Data.Car, Bool)? in
                switch item {
                case let .car(data):
                    return (data, false)
                case let .highlightedCar(data):
                    return (data, true)
                case .brand:
                    return nil
                }
            }
            .forEach { (car, isHighlighted) in
                self.items[car.id] = (car, isHighlighted)
            }
    }
    
    func loadData() {
        presenter.present(isLoading: true)
        service.fetch(request: CarSearch.Request()) { [weak self] result in
            guard let self = self else { return }
            self.presenter.present(isLoading: false)
            switch result {
            case let .success(response):
                self.buffer(response)
                self.presenter.present(data: response)
            case let .failure(error):
                self.presenter.present(error: error)
            }
        }
    }
    
    func request(request: CarsList.Request) {
        switch request {
        case let .car(id):
            guard let (car, isHighlighted) = items[id] else { break }
            router.routeToDetails(car: car, isHighlihted: isHighlighted)
        case .reload:
            loadData()
        }
    }
}
