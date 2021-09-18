//
//  CarSearchAssembly.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import Swinject

final class CarSearchAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CarSearchServiceProtocol.self) { _ in
            CarSearchServiceMock()
        }
    }
}
