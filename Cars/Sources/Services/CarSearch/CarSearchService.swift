//
//  CarSearchService.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import Foundation

protocol CarSearchServiceProtocol {
    func fetch(request: CarSearch.Request, completion: @escaping (Result<CarSearch.Response, Error>) -> Void)
}

final class CarSearchServiceMock: CarSearchServiceProtocol {
    func fetch(request: CarSearch.Request, completion: @escaping (Result<CarSearch.Response, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let url = Bundle.main.url(forResource: "CarSearch", withExtension: "json")!
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(CarSearch.Response.self, from: jsonData)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
