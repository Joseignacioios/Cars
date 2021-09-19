//
//  CarDetailAssembly.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

import Swinject

final class CarDetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CarDetailBuilderProtocol.self) { resolver in
            CarDetailBuilder(
                mapper: resolver.resolve(CarMapperProtocol.self)!
            )
        }
    }
}
