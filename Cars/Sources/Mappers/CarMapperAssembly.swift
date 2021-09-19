//
//  CarMapperAssembly.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

import Swinject

final class CarMapperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CarMapperProtocol.self) { _ in
            CarMapper()
        }
    }
}
