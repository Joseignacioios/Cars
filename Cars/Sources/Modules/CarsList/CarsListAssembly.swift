//
//  CarsListAssembly.swift
//  Cars
//
//  Created by Joce on 18.09.2021.
//

import Swinject

final class CarsListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CarsListBuilderProtocol.self) { _ in
            CarsListBuilder()
        }
    }
}
